import "sort"

func kthSmallestPrimeFraction(A []int, K int) []int {
    n := len(A)
    left, right := 0.0, 1.0
    var ans []int

    for left < right {
        mid := (left + right) / 2
        count, maxNum := 0, 0
        j := 1

        for i := 0; i < n; i++ {
            for j < n && float64(A[i]) / float64(A[j]) < mid {
                j++
            }
            count += j - 1
            if j > 1 && A[i] * maxNum > A[j-1] * maxNum {
                maxNum = A[i]
                ans = []int{A[i], A[j-1]}
            }
        }

        if count < K {
            left = mid
        } else {
            right = mid
        }
    }

    return ans
}