func countBeautifulPairs(nums []int) int {
    count := 0
    n := len(nums)
    for i := 0; i < n; i++ {
        first := nums[i]
        for first >= 10 {
            first /= 10
        }
        for j := i + 1; j < n; j++ {
            last := nums[j] % 10
            if gcd(first, last) == 1 {
                count++
            }
        }
    }
    return count
}

func gcd(a, b int) int {
    for b != 0 {
        a, b = b, a%b
    }
    return a
}