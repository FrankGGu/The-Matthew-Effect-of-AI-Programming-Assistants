package main

func buildArray(nums []int, target int) []string {
    res := []string{}
    n := len(nums)
    i := 0
    for i < n && nums[i] <= target {
        if nums[i] == target {
            res = append(res, "Push")
            break
        }
        res = append(res, "Push", "Pop")
        i++
    }
    return res
}