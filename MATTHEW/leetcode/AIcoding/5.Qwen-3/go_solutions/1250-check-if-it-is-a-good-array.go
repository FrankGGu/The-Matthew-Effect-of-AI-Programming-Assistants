package main

func isGoodArray(nums []int) bool {
    gcd := nums[0]
    for i := 1; i < len(nums); i++ {
        gcd = findGCD(gcd, nums[i])
    }
    return gcd == 1
}

func findGCD(a, b int) int {
    for b != 0 {
        a, b = b, a%b
    }
    return a
}