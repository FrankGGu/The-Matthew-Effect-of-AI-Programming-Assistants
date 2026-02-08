func subarraysWithKDistinct(A []int, K int) int {
    return atMostK(A, K) - atMostK(A, K-1)
}

func atMostK(A []int, K int) int {
    count := make(map[int]int)
    left, res := 0, 0
    for right := 0; right < len(A); right++ {
        if count[A[right]] == 0 {
            K--
        }
        count[A[right]]++
        for K < 0 {
            count[A[left]]--
            if count[A[left]] == 0 {
                K++
            }
            left++
        }
        res += right - left + 1
    }
    return res
}