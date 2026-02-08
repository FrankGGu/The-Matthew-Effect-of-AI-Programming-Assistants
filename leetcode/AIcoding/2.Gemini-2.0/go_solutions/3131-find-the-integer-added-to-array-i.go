func addToArrayForm(num []int, k int) []int {
    res := []int{}
    i := len(num) - 1
    carry := 0
    for i >= 0 || k > 0 || carry > 0 {
        digit := carry
        if i >= 0 {
            digit += num[i]
            i--
        }
        if k > 0 {
            digit += k % 10
            k /= 10
        }
        carry = digit / 10
        res = append([]int{digit % 10}, res...)
    }
    return res
}