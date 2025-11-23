func findMaxK(nums []int) int {
    positive := make(map[int]bool)
    maxK := -1

    for _, num := range nums {
        if num > 0 {
            positive[num] = true
        }
    }

    for _, num := range nums {
        if num < 0 && positive[-num] {
            if -num > maxK {
                maxK = -num
            }
        }
    }

    return maxK
}