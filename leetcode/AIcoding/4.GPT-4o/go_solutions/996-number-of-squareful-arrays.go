import (
    "sort"
)

func numSquarefulPerms(A []int) int {
    sort.Ints(A)
    count := 0
    used := make([]bool, len(A))
    var backtrack func(path []int)

    backtrack = func(path []int) {
        if len(path) == len(A) {
            count++
            return
        }
        for i := 0; i < len(A); i++ {
            if used[i] || (i > 0 && A[i] == A[i-1] && !used[i-1]) {
                continue
            }
            if len(path) == 0 || isSquareful(path[len(path)-1], A[i]) {
                used[i] = true
                backtrack(append(path, A[i]))
                used[i] = false
            }
        }
    }

    backtrack([]int{})
    return count
}

func isSquareful(a, b int) bool {
    sum := a + b
    sqrt := intSqrt(sum)
    return sqrt*sqrt == sum
}

func intSqrt(x int) int {
    if x < 0 {
        return -1
    }
    left, right := 0, x
    for left <= right {
        mid := left + (right-left)/2
        if mid*mid == x {
            return mid
        } else if mid*mid < x {
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    return right
}