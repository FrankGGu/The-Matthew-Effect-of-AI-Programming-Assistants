func findMaxK(nums []int) int {
    seen := make(map[int]bool)
    for _, num := range nums {
        seen[num] = true
    }

    maxK := -1
    for _, num := range nums {
        if num > 0 {
            if seen[-num] {
                if num > maxK {
                    maxK = num
                }
            }
        }
    }