func maximumDifference(nums []int) int {
    maxDiff := -1
    minSoFar := nums[0]

    for i := 1; i < len(nums); i++ {
        if nums[i] > minSoFar {
            if nums[i]-minSoFar > maxDiff {
                maxDiff = nums[i] - minSoFar
            }
        }
        if nums[i] < minSoFar {
            minSoFar = nums[i]
        }
    }

    return maxDiff
}