import "math"

func minOperations(nums []int, x int) int {
    totalSum := 0
    for _, num := range nums {
        totalSum += num
    }

    targetSum := totalSum - x
    n := len(nums)

    maxLength := -1 
    currentSum := 0
    left := 0

    for right := 0; right < n; right++ {
        currentSum += nums[right]

        for currentSum > targetSum && left <= right {
            currentSum -= nums[left]
            left++
        }

        if currentSum == targetSum {
            maxLength = int(math.Max(float64(maxLength), float64(right-left+1)))
        }
    }

    if maxLength == -1 {
        return -1
    }

    return n - maxLength
}