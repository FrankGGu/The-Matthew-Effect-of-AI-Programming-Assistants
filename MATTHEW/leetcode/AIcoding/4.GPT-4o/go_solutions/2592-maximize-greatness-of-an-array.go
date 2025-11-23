func maximizeGreatness(nums []int) int {
    sort.Ints(nums)
    greatness := 0
    for i, num := range nums {
        if i == 0 || num > nums[greatness-1] {
            greatness++
        }
    }
    return greatness
}