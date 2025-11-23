import "sort"

func threeSumClosest(nums []int, target int) int {
    sort.Ints(nums)
    closest := nums[0] + nums[1] + nums[2]

    for i := 0; i < len(nums)-2; i++ {
        left, right := i+1, len(nums)-1
        for left < right {
            currentSum := nums[i] + nums[left] + nums[right]
            if abs(currentSum-target) < abs(closest-target) {
                closest = currentSum
            }
            if currentSum < target {
                left++
            } else if currentSum > target {
                right--
            } else {
                return currentSum
            }
        }
    }

    return closest
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}