func sumOfArrayProducts(nums []int, k int) int {
    n := len(nums)
    ans := 0
    mod := 1000000007
    for i := 0; i < n; i++ {
        for j := i; j < n; j++ {
            subArray := nums[i : j+1]
            if len(subArray) >= k {
                product := 1
                for l := 0; l < len(subArray); l++ {
                    product = (product * subArray[l]) % mod
                }
                ans = (ans + product) % mod
            }
        }
    }
    return ans
}