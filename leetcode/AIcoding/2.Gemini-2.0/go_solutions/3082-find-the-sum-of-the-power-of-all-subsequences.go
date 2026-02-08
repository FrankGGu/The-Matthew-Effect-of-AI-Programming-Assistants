func sumPower(nums []int) int {
    sort.Ints(nums)
    mod := 1000000007
    ans := 0
    pow := 1
    for _, num := range nums {
        ans = (ans + (num * num) % mod * (num + pow) % mod) % mod
        pow = (pow * 2) % mod
    }
    return ans
}