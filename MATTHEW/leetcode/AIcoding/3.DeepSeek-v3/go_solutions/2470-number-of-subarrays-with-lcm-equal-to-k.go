func subarrayLCM(nums []int, k int) int {
    count := 0
    n := len(nums)
    for i := 0; i < n; i++ {
        currentLCM := 1
        for j := i; j < n; j++ {
            currentLCM = lcm(currentLCM, nums[j])
            if currentLCM == k {
                count++
            } else if currentLCM > k {
                break
            }
        }
    }
    return count
}

func gcd(a, b int) int {
    for b != 0 {
        a, b = b, a % b
    }
    return a
}

func lcm(a, b int) int {
    return a * b / gcd(a, b)
}