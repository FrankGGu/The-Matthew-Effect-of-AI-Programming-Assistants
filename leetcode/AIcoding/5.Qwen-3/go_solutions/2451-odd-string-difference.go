package main

func oddString(s []string) string {
    diffMap := make(map[string][]string)
    for _, word := range s {
        var diff []int
        for i := 1; i < len(word); i++ {
            diff = append(diff, int(word[i]-word[i-1]))
        }
        key := ""
        for _, d := range diff {
            key += strconv.Itoa(d) + ","
        }
        diffMap[key] = append(diffMap[key], word)
    }
    for _, v := range diffMap {
        if len(v) == 1 {
            return v[0]
        }
    }
    return ""
}