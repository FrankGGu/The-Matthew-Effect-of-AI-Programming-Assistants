func numSubseq(nums []int, target int) int {
    const mod = 1_000_000_007
    n := len(nums)
    sort.Ints(nums)

    left, right := 0, n-1
    result := 0

    pow := make([]int, n)
    pow[0] = 1
    for i := 1; i < n; i++ {
        pow[i] = (pow[i-1] * 2) % mod
    }

    for left <= right {
        if nums[left]+nums[right] > target {
            right--
        } else {
            result = (result + pow[right-left]) % mod
            left++
        }
    }

    return result
}