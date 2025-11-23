func minBooths(needs []string) int {
    maxCount := make([]int, 26)
    for _, need := range needs {
        count := make([]int, 26)
        for _, c := range need {
            count[c-'a']++
        }
        for i := 0; i < 26; i++ {
            if count[i] > maxCount[i] {
                maxCount[i] = count[i]
            }
        }
    }
    total := 0
    for _, num := range maxCount {
        total += num
    }
    return total
}