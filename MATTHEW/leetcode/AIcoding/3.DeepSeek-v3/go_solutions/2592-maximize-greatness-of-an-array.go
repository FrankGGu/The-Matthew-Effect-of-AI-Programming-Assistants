import "sort"

func maximizeGreatness(nums []int) int {
    sort.Ints(nums)
    res := 0
    for i := 0; i < len(nums); i++ {
        if nums[res] < nums[i] {
            res++
        }
    }
    return res
}