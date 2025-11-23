import "sort"

func matrixSum(nums [][]int) int {
    for i := range nums {
        sort.Sort(sort.Reverse(sort.IntSlice(nums[i])))
    }
    sum := 0
    for j := 0; j < len(nums[0]); j++ {
        maxVal := 0
        for i := 0; i < len(nums); i++ {
            if nums[i][j] > maxVal {
                maxVal = nums[i][j]
            }
        }
        sum += maxVal
    }
    return sum
}