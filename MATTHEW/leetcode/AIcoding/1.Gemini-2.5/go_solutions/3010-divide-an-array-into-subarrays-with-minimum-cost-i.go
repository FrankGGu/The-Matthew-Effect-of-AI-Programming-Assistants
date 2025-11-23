import "math"

func minimumCost(nums []int) int {
    n := len(nums)

    // The first element nums[0] is always part of the cost.
    totalCost := nums[0]

    // We need to find the two smallest elements among nums[1], nums[2], ..., nums[n-1].
    // These will be nums[i] and nums[j] for the minimum cost.
    min1 := math.MaxInt32 // Stores the smallest value found in nums[1:]
    min2 := math.MaxInt32 // Stores the second smallest value found in nums[1:]

    for i := 1; i < n; i++ {
        if nums[i] < min1 {
            min2 = min1 // The previous smallest becomes the new second smallest
            min1 = nums[i] // Current element is the new smallest
        } else if nums[i] < min2 {
            min2 = nums[i] // Current element is smaller than second smallest, but not smaller than smallest
        }
    }

    // Add the two smallest elements found to the total cost.
    totalCost += min1 + min2

    return totalCost
}