import "sort"

func reductionOperations(nums []int) int {
    sort.Ints(nums)
    res := 0
    n := len(nums)
    for i := n - 1; i > 0; i-- {
        if nums[i] != nums[i-1] {
            res += n - i
        }
    }
    return res
}