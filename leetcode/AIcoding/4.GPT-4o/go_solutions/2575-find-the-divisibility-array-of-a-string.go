func divisibilityArray(word string, m int) []int {
    n := len(word)
    result := make([]int, n)
    current := 0

    for i := 0; i < n; i++ {
        current = (current*10 + int(word[i]-'0')) % m
        if current == 0 {
            result[i] = 1
        }
    }

    return result
}