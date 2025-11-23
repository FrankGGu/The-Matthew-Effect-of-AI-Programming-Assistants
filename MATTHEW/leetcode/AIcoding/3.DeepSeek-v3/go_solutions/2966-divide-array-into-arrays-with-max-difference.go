func divideArray(nums []int, k int) [][]int {
    sort.Ints(nums)
    res := [][]int{}
    for i := 0; i < len(nums); i += 3 {
        if i+2 >= len(nums) {
            return [][]int{}
        }
        if nums[i+2]-nums[i] > k {
            return [][]int{}
        }
        res = append(res, []int{nums[i], nums[i+1], nums[i+2]})
    }
    return res
}