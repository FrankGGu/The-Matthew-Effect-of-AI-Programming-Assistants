func containsNearbyDuplicate(nums []int, k int) bool {
    numMap := make(map[int]int) // Maps number to its last seen index

    for i, num := range nums {
        if prevIdx, found := numMap[num]; found {
            if i - prevIdx <= k {
                return true
            }
        }
        numMap[num] = i // Update the last seen index for the current number
    }

    return false
}