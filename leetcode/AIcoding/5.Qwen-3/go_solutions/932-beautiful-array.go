package main

func beautifulArray(n int) []int {
    result := make([]int, 0)
    var helper func(int, int)
    helper = func(n, k int) {
        if n == 1 {
            result = append(result, k)
            return
        }
        helper(n/2, k)
        helper(n/2, k+n/2)
        for i := 0; i < n/2; i++ {
            result = append(result, result[len(result)-1-i])
        }
    }
    helper(n, 1)
    return result
}