func countHillsAndValleys(nums []int) int {
    if len(nums) < 3 {
        return 0
    }
    count := 0
    for i := 1; i < len(nums)-1; i++ {
        if (nums[i] > nums[i-1] && nums[i] > nums[i+1]) || (nums[i] < nums[i-1] && nums[i] < nums[i+1]) {
            count++
            for i < len(nums)-1 && nums[i] == nums[i+1] {
                i++
            }
        }
    }
    return count
}