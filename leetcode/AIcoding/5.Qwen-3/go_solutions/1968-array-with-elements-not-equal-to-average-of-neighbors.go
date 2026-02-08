package main

func rearrangeArray(nums []int) []int {
    sort.Ints(nums)
    res := make([]int, len(nums))
    left, right := 0, len(nums)-1
    for i := 0; i < len(nums); i++ {
        if i%2 == 0 {
            res[i] = nums[left]
            left++
        } else {
            res[i] = nums[right]
            right--
        }
    }
    return res
}