func permute(nums []int) [][]int {
    var res [][]int
    backtrack(&res, nums, 0)
    return res
}

func backtrack(res *[][]int, nums []int, start int) {
    if start == len(nums) {
        tmp := make([]int, len(nums))
        copy(tmp, nums)
        *res = append(*res, tmp)
        return
    }
    for i := start; i < len(nums); i++ {
        nums[start], nums[i] = nums[i], nums[start]
        backtrack(res, nums, start+1)
        nums[start], nums[i] = nums[i], nums[start]
    }
}