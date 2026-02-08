func mergeArrays(nums1 [][]int, nums2 [][]int) [][]int {
    m := make(map[int]int)
    for _, num := range nums1 {
        m[num[0]] += num[1]
    }
    for _, num := range nums2 {
        m[num[0]] += num[1]
    }
    result := [][]int{}
    for k, v := range m {
        result = append(result, []int{k, v})
    }
    sort.Slice(result, func(i, j int) bool {
        return result[i][0] < result[j][0]
    })
    return result
}

import "sort"