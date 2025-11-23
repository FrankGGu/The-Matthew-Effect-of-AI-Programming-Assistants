func numSquarefulPerms(A []int) int {
    n := len(A)
    if n == 0 {
        return 0
    }
    sort.Ints(A)
    used := make([]bool, n)
    res := 0
    backtrack(A, used, []int{}, &res)
    return res
}

func backtrack(A []int, used []bool, path []int, res *int) {
    if len(path) == len(A) {
        *res++
        return
    }
    for i := 0; i < len(A); i++ {
        if used[i] || (i > 0 && A[i] == A[i-1] && !used[i-1]) {
            continue
        }
        if len(path) > 0 {
            sum := path[len(path)-1] + A[i]
            root := int(math.Sqrt(float64(sum)))
            if root*root != sum {
                continue
            }
        }
        used[i] = true
        path = append(path, A[i])
        backtrack(A, used, path, res)
        path = path[:len(path)-1]
        used[i] = false
    }
}