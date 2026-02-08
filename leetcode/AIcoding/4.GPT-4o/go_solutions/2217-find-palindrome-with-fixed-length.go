func palindromeNumbers(n int, k int) []int {
    result := []int{}
    start := int(math.Pow(10, float64(k-1)))
    end := int(math.Pow(10, float64(k))) - 1

    for i := start; i <= end; i++ {
        if isPalindrome(i) {
            result = append(result, i)
        }
        if len(result) == n {
            break
        }
    }
    return result
}

func isPalindrome(num int) bool {
    str := strconv.Itoa(num)
    left, right := 0, len(str)-1
    for left < right {
        if str[left] != str[right] {
            return false
        }
        left++
        right--
    }
    return true
}