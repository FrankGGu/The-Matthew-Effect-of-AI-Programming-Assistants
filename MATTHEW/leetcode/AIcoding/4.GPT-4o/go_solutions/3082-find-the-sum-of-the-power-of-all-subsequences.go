func sumOfPower(nums []int) int {
    const mod = 1_000_000_007
    n := len(nums)
    sort.Ints(nums)

    powerSum := 0
    sum := 0
    for i := 0; i < n; i++ {
        sum = (sum*2 + nums[i]) % mod
        powerSum = (powerSum + sum) % mod
    }

    return powerSum
}