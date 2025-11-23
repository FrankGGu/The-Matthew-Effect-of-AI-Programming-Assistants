func findMaxK(nums []int) int {
    seen := make(map[int]bool)
    maxK := -1
    for _, num := range nums {
        seen[num] = true
    }
    for _, num := range nums {
        if num > 0 && seen[-num] {
            if num > maxK {
                maxK = num
            }
        }
    }
    return maxK
}