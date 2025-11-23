package main

func sumOfPower(nums []int) int {
    MOD := int64(1000000007)
    n := len(nums)
    result := int64(0)
    for i := 0; i < n; i++ {
        power := int64(1)
        for j := i; j < n; j++ {
            power = (power * int64(nums[j])) % MOD
            result = (result + power) % MOD
        }
    }
    return int(result)
}