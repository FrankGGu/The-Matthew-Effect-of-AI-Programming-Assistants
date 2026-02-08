func findAdjacentIncreasingSubarrays(nums []int) [][]int {
    var result [][]int
    n := len(nums)

    for i := 0; i < n-1; i++ {
        if nums[i] < nums[i+1] {
            start := i
            for i < n-1 && nums[i] < nums[i+1] {
                i++
            }
            result = append(result, nums[start:i+1])
        }
    }

    return result
}