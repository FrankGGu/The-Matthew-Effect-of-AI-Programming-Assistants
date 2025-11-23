package main

func numberOfSubarrays(s string, a []int) int {
    n := len(a)
    count := 0
    for i := 0; i < n; i++ {
        if a[i] == 0 {
            count++
        }
    }
    if count == n {
        return 1
    }
    pattern := make([]int, n)
    for i := 0; i < n; i++ {
        if a[i] == 0 {
            pattern[i] = 0
        } else if a[i] > 0 {
            pattern[i] = 1
        } else {
            pattern[i] = -1
        }
    }
    m := len(s)
    res := 0
    for i := 0; i < m; i++ {
        j := 0
        k := i
        for k < m && j < n {
            if (s[k] > s[k-1] && pattern[j] == 1) || (s[k] < s[k-1] && pattern[j] == -1) || (s[k] == s[k-1] && pattern[j] == 0) {
                j++
                k++
            } else {
                break
            }
        }
        if j == n {
            res++
        }
    }
    return res
}