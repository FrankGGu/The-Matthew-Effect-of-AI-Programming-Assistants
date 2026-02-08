package main

func occurrencesAfterBigRepeats(nums []int, x int) []int {
    result := []int{}
    for i := 0; i < len(nums)-1; i++ {
        if nums[i] == x && nums[i+1] == x {
            if i+2 < len(nums) {
                result = append(result, nums[i+2])
            }
        }
    }
    return result
}