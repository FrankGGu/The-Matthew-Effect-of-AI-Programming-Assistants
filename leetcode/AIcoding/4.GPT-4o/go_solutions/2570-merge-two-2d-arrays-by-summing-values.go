func mergeArrays(nums1 [][]int, nums2 [][]int) [][]int {
    result := make(map[int]int)

    for _, arr := range nums1 {
        result[arr[0]] += arr[1]
    }

    for _, arr := range nums2 {
        result[arr[0]] += arr[1]
    }

    res := make([][]int, 0, len(result))
    for k, v := range result {
        res = append(res, []int{k, v})
    }

    sort.Slice(res, func(i, j int) bool {
        return res[i][0] < res[j][0]
    })

    return res
}