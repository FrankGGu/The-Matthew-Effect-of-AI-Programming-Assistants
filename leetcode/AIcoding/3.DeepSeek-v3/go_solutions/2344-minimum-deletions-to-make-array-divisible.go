func minOperations(nums []int, numsDivide []int) int {
    gcdAll := numsDivide[0]
    for _, num := range numsDivide[1:] {
        gcdAll = gcd(gcdAll, num)
    }

    sort.Ints(nums)
    for i, num := range nums {
        if gcdAll % num == 0 {
            return i
        }
    }
    return -1
}

func gcd(a, b int) int {
    for b != 0 {
        a, b = b, a % b
    }
    return a
}