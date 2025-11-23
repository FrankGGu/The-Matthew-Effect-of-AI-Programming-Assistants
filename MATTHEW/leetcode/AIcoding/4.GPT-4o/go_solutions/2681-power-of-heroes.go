func powerOfHeroes(nums []int) int {
    n := len(nums)
    mod := 1_000_000_007
    sort.Ints(nums)

    result := 0
    for i := 0; i < n; i++ {
        result = (result + pow(nums[i], i+1, mod)) % mod
    }

    return result
}

func pow(base, exp, mod int) int {
    result := 1
    base = base % mod
    for exp > 0 {
        if exp%2 == 1 {
            result = (result * base) % mod
        }
        exp >>= 1
        base = (base * base) % mod
    }
    return result
}