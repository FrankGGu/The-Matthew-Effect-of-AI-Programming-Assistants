import "sort"

func minDeletions(nums []int, numsDivide []int) int {
    gcd := numsDivide[0]
    for _, num := range numsDivide[1:] {
        gcd = gcdFunc(gcd, num)
    }

    sort.Ints(nums)
    count := 0

    for _, num := range nums {
        if gcd%num == 0 {
            return count
        }
        count++
    }

    return -1
}

func gcdFunc(a, b int) int {
    for b != 0 {
        a, b = b, a%b
    }
    return a
}