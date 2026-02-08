func subarrayGCD(nums []int, k int) int {
    n := len(nums)
    count := 0
    for i := 0; i < n; i++ {
        currentGCD := nums[i]
        for j := i; j < n; j++ {
            currentGCD = gcd(currentGCD, nums[j])
            if currentGCD == k {
                count++
            } else if currentGCD < k {
                break
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