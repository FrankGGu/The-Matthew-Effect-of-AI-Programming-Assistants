func areNumbersAscending(s string) bool {
    words := strings.Fields(s)
    prevNum := -1

    for _, word := range words {
        num, err := strconv.Atoi(word)
        if err == nil {
            if num <= prevNum {
                return false
            }
            prevNum = num
        }
    }

    return true
}