func maximumValue(strs []string) int {
    maxVal := 0
    for _, s := range strs {
        if num, err := strconv.Atoi(s); err == nil {
            if num > maxVal {
                maxVal = num
            }
        } else {
            if len(s) > maxVal {
                maxVal = len(s)
            }
        }
    }
    return maxVal
}