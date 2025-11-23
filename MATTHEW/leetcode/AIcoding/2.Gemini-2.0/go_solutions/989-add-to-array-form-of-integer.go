func addToArrayForm(num []int, k int) []int {
    n := len(num)
    res := []int{}
    carry := 0
    for i := n - 1; i >= 0 || k > 0 || carry > 0; i-- {
        digit := carry
        if i >= 0 {
            digit += num[i]
        }
        if k > 0 {
            digit += k % 10
            k /= 10
        }
        carry = digit / 10
        res = append(res, digit%10)
    }
    for i, j := 0, len(res)-1; i < j; i, j = i+1, j-1 {
        res[i], res[j] = res[j], res[i]
    }
    return res
}