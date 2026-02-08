package main

func createTargetArray(nums []int, index []int) []int {
    target := make([]int, 0)
    for i := 0; i < len(nums); i++ {
        target = append(target[:index[i]], append([]int{nums[i]}, target[index[i]:]...)...)
    }
    return target
}