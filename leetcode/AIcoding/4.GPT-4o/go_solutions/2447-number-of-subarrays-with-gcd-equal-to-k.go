func subarrayGCD(nums []int, k int) int {
    count := 0
    n := len(nums)

    for i := 0; i < n; i++ {
        currentGCD := 0
        for j := i; j < n; j++ {
            currentGCD = gcd(currentGCD, nums[j])
            if currentGCD < k {
                break
            }
            if currentGCD == k {
                count++
            }
        }
    }

    return count
}

func gcd(a, b int) int {
    if b == 0 {
        return a
    }
    return gcd(b, a%b)
}