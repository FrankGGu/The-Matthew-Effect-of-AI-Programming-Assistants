package main

func numSquarefulArrays(nums []int, k int) int {
    var result int
    used := make([]bool, len(nums))
    var backtrack func(path []int)
    backtrack = func(path []int) {
        if len(path) == len(nums) {
            result++
            return
        }
        for i := 0; i < len(nums); i++ {
            if used[i] {
                continue
            }
            if len(path) > 0 {
                s := path[len(path)-1] + nums[i]
                sqrtS := int(math.Sqrt(float64(s)))
                if sqrtS*sqrtS != s {
                    continue
                }
            }
            used[i] = true
            backtrack(append(path, nums[i]))
            used[i] = false
        }
    }
    backtrack([]int{})
    return result
}