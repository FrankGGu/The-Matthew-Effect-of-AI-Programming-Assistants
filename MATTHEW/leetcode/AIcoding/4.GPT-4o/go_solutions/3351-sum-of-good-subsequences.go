func sumOfGoodSubsequences(nums []int) int {
    mod := int(1e9 + 7)
    sum := 0
    count := 0
    for _, num := range nums {
        count = (count*2 + 1) % mod
        sum = (sum + num*count) % mod
    }
    return sum
}