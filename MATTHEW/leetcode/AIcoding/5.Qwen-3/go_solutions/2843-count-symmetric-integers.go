package main

func countSymmetricIntegers(nums []int) int {
    count := 0
    for _, num := range nums {
        s := strconv.Itoa(num)
        if len(s)%2 != 0 {
            continue
        }
        half := len(s) / 2
        left := s[:half]
        right := s[half:]
        if left == reverse(right) {
            count++
        }
    }
    return count
}

func reverse(s string) string {
    runes := []rune(s)
    for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
        runes[i], runes[j] = runes[j], runes[i]
    }
    return string(runes)
}