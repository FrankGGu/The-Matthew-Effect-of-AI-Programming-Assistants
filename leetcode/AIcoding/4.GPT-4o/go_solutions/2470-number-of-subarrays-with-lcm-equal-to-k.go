func subarrayLCM(nums []int, k int) int {
    count := 0
    n := len(nums)

    for i := 0; i < n; i++ {
        lcm := 1
        for j := i; j < n; j++ {
            lcm = lcm * nums[j] / gcd(lcm, nums[j])
            if lcm > k {
                break
            }
            if lcm == k {
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