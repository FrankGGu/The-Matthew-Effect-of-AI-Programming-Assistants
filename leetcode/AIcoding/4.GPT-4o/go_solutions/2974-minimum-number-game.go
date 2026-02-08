func minimumNumber(nums []int) int {
    result := nums[0]
    for _, num := range nums[1:] {
        result = gcd(result, num)
    }
    return result
}

func gcd(a, b int) int {
    for b != 0 {
        a, b = b, a%b
    }
    return a
}