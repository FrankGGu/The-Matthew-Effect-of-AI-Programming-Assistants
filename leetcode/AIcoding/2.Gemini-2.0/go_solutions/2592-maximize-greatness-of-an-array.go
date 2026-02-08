import "sort"

func maximizeGreatness(nums []int) int {
    n := len(nums)
    sort.Ints(nums)
    count := 0
    j := 0
    for i := 0; i < n; i++ {
        if nums[i] > nums[j] {
            count++
            j++
        }
    }
    return count
}