func sumOfPower(nums []int) int {
    sort.Ints(nums)
    mod := 1000000007
    sum := 0
    res := 0
    for _, num := range nums {
        res = (res + num*num%mod*(num+sum)%mod) % mod
        sum = (sum*2%mod + num) % mod
    }
    return res
}