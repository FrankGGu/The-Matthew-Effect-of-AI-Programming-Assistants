func addToArrayForm(num []int, k int) []int {
    carry := 0
    i := len(num) - 1
    res := []int{}

    for i >= 0 || k > 0 || carry > 0 {
        sum := carry
        if i >= 0 {
            sum += num[i]
            i--
        }
        if k > 0 {
            sum += k % 10
            k /= 10
        }
        carry = sum / 10
        res = append([]int{sum % 10}, res...)
    }

    return res
}