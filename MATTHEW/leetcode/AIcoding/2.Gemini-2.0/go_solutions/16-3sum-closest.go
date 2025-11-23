import "sort"
import "math"

func threeSumClosest(nums []int, target int) int {
    sort.Ints(nums)
    closest := nums[0] + nums[1] + nums[2]
    for i := 0; i < len(nums)-2; i++ {
        left := i + 1
        right := len(nums) - 1
        for left < right {
            sum := nums[i] + nums[left] + nums[right]
            if math.Abs(float64(sum-target)) < math.Abs(float64(closest-target)) {
                closest = sum
            }
            if sum < target {
                left++
            } else if sum > target {
                right--
            } else {
                return target
            }
        }
    }
    return closest
}