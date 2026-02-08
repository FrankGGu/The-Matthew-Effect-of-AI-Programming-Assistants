func addNegabinary(A []int, B []int) []int {
    n, m := len(A), len(B)
    carry := 0
    result := []int{}

    for i := 0; i < n || i < m || carry != 0; i++ {
        if i < n {
            carry += A[n-1-i]
        }
        if i < m {
            carry += B[m-1-i]
        }

        result = append(result, carry & 1)
        carry = -(carry >> 1)
    }

    // Remove leading zeros
    for len(result) > 1 && result[len(result)-1] == 0 {
        result = result[:len(result)-1]
    }

    // Reverse the result
    for i, j := 0, len(result)-1; i < j; i, j = i+1, j-1 {
        result[i], result[j] = result[j], result[i]
    }

    return result
}