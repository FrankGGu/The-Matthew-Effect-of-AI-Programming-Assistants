package main

func kthSmallestProduct(n int, m int, a []int, b []int, k int) int {
    left := -1000000000
    right := 1000000000

    for left < right {
        mid := left + (right-left)/2
        count := 0

        i := len(b) - 1
        j := 0

        for i >= 0 && j < len(a) {
            if a[j]*b[i] <= mid {
                count += i + 1
                j++
            } else {
                i--
            }
        }

        if count < k {
            left = mid + 1
        } else {
            right = mid
        }
    }

    return left
}