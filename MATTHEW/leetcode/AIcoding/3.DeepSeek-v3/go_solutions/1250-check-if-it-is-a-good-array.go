func isGoodArray(nums []int) bool {
    gcd := nums[0]
    for _, num := range nums {
        gcd = computeGCD(gcd, num)
        if gcd == 1 {
            return true
        }
    }
    return gcd == 1
}

func computeGCD(a, b int) int {
    for b != 0 {
        a, b = b, a%b
    }
    return a
}