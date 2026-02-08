package main

func canFormArray(boxes []int, nums [][]int) bool {
    indexMap := make(map[int]int)
    for i, num := range nums {
        indexMap[num[0]] = i
    }

    i := 0
    for i < len(boxes) {
        if idx, ok := indexMap[boxes[i]]; ok {
            j := 0
            for j < len(nums[idx]) && i < len(boxes) && boxes[i] == nums[idx][j] {
                i++
                j++
            }
            if j != len(nums[idx]) {
                return false
            }
        } else {
            return false
        }
    }
    return true
}