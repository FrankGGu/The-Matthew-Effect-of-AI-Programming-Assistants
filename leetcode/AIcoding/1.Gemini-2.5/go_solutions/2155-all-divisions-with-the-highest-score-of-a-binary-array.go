func maxScoreIndices(nums []int) []int {
    n := len(nums)

    // Calculate total number of ones in the array
    totalOnes := 0
    for _, num := range nums {
        if num == 1 {
            totalOnes++
        }
    }