func checkIfPangram(sentence string) bool {
    seen := make([]bool, 26)
    count := 0

    for _, char := range sentence {
        idx := char - 'a'
        if !seen[idx] {
            seen[idx] = true
            count++
        }
    }

    return count == 26
}