func alertNames(keyName []string, keyTime []string) []string {
    nameToTimes := make(map[string][]int)
    for i, name := range keyName {
        timeStr := keyTime[i]
        hours := int(timeStr[0]-'0')*10 + int(timeStr[1]-'0')
        minutes := int(timeStr[3]-'0')*10 + int(timeStr[4]-'0')
        total := hours*60 + minutes
        nameToTimes[name] = append(nameToTimes[name], total)
    }

    res := []string{}
    for name, times := range nameToTimes {
        sort.Ints(times)
        for i := 2; i < len(times); i++ {
            if times[i] - times[i-2] <= 60 {
                res = append(res, name)
                break
            }
        }
    }
    sort.Strings(res)
    return res
}