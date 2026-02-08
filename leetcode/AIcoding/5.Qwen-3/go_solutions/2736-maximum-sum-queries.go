package main

func maximumSumQueries(nums1 []int, nums2 []int, queries []int) []int {
    type pair struct {
        val int
        idx int
    }
    n := len(nums1)
    m := len(queries)
    res := make([]int, m)
    for i := range queries {
        res[i] = -1
    }
    sortedQueries := make([]pair, m)
    for i := range queries {
        sortedQueries[i] = pair{queries[i], i}
    }
    sort.Slice(sortedQueries, func(i, j int) bool {
        return sortedQueries[i].val < sortedQueries[j].val
    })
    type info struct {
        num1 int
        num2 int
        idx  int
    }
    list := make([]info, n)
    for i := range nums1 {
        list[i] = info{nums1[i], nums2[i], i}
    }
    sort.Slice(list, func(i, j int) bool {
        return list[i].num1 < list[j].num1
    })
    j := 0
    stack := make([]int, 0)
    for _, q := range sortedQueries {
        target := q.val
        idx := q.idx
        for j < n && list[j].num1 <= target {
            for len(stack) > 0 && list[j].num2 >= list[stack[len(stack)-1]].num2 {
                stack = stack[:len(stack)-1]
            }
            stack = append(stack, j)
            j++
        }
        left, right := 0, len(stack)-1
        ans := -1
        for left <= right {
            mid := (left + right) / 2
            if list[stack[mid]].num1 <= target {
                ans = list[stack[mid]].num2
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        res[idx] = ans
    }
    return res
}