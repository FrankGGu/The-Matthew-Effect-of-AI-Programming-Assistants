func addToArrayForm(num []int, k int) []int {
    n := len(num)
    result := make([]int, 0, n+len(strconv.Itoa(k)))
    carry := 0
    for i := n - 1; i >= 0 || k > 0 || carry > 0; i-- {
        if i >= 0 {
            carry += num[i]
        }
        if k > 0 {
            carry += k % 10
            k /= 10
        }
        result = append(result, carry%10)
        carry /= 10
    }
    reverse(result)
    return result
}

func reverse(arr []int) {
    for i, j := 0, len(arr)-1; i < j; i, j = i+1, j-1 {
        arr[i], arr[j] = arr[j], arr[i]
    }
}