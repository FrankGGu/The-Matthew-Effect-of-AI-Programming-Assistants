func relativeSortArray(arr1 []int, arr2 []int) []int {
    m := make(map[int]int)
    for _, v := range arr1 {
        m[v]++
    }
    res := []int{}
    for _, v := range arr2 {
        for i := 0; i < m[v]; i++ {
            res = append(res, v)
        }
        delete(m, v)
    }
    remaining := []int{}
    for k := range m {
        for i := 0; i < m[k]; i++ {
            remaining = append(remaining, k)
        }
    }
    sort.Ints(remaining)
    res = append(res, remaining...)
    return res
}

import "sort"