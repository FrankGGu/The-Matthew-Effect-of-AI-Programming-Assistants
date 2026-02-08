func twoOutOfThree(nums1 []int, nums2 []int, nums3 []int) []int {
    count := make(map[int]int)
    mark := make(map[int]map[int]bool)

    for _, num := range nums1 {
        if _, exists := mark[num]; !exists {
            mark[num] = make(map[int]bool)
        }
        if !mark[num][1] {
            mark[num][1] = true
            count[num]++
        }
    }

    for _, num := range nums2 {
        if _, exists := mark[num]; !exists {
            mark[num] = make(map[int]bool)
        }
        if !mark[num][2] {
            mark[num][2] = true
            count[num]++
        }
    }

    for _, num := range nums3 {
        if _, exists := mark[num]; !exists {
            mark[num] = make(map[int]bool)
        }
        if !mark[num][3] {
            mark[num][3] = true
            count[num]++
        }
    }

    var result []int
    for num, cnt := range count {
        if cnt >= 2 {
            result = append(result, num)
        }
    }

    return result
}