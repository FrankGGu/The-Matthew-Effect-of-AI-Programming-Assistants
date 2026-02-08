func addNegabinary(arr1 []int, arr2 []int) []int {
    res := []int{}
    carry := 0
    i, j := len(arr1)-1, len(arr2)-1

    for i >= 0 || j >= 0 || carry != 0 {
        if i >= 0 {
            carry += arr1[i]
            i--
        }
        if j >= 0 {
            carry += arr2[j]
            j--
        }
        res = append(res, carry & 1)
        carry = -(carry >> 1)
    }

    for len(res) > 1 && res[len(res)-1] == 0 {
        res = res[:len(res)-1]
    }

    reverse(res)
    return res
}

func reverse(arr []int) {
    for i, j := 0, len(arr)-1; i < j; i, j = i+1, j-1 {
        arr[i], arr[j] = arr[j], arr[i]
    }
}