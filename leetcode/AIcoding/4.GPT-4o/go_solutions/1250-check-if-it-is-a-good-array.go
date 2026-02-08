func isGoodArray(nums []int) bool {
    gcd := nums[0]
    for _, num := range nums[1:] {
        gcd = gcdOfNumbers(gcd, num)
        if gcd == 1 {
            return true
        }
    }
    return gcd == 1
}

func gcdOfNumbers(a, b int) int {
    for b != 0 {
        a, b = b, a%b
    }
    return a
}