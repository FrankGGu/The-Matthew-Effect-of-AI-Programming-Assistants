import "sort"

func numSubseq(nums []int, target int) int {
    sort.Ints(nums)
    n := len(nums)
    ans := 0
    mod := 1000000007
    pow := make([]int, n)
    pow[0] = 1
    for i := 1; i < n; i++ {
        pow[i] = (pow[i-1] * 2) % mod
    }

    for i := 0; i < n; i++ {
        if nums[i]*2 > target {
            break
        }
        j := sort.Search(n, func(j int) bool {
            return nums[i]+nums[j] > target
        })
        j--
        if j >= i {
            ans = (ans + pow[j-i]) % mod
        }
    }
    return ans
}