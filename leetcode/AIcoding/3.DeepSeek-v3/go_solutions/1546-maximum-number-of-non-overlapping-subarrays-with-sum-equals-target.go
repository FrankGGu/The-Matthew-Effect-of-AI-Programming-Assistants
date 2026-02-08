func maxNonOverlapping(nums []int, target int) int {
    prefixSum := make(map[int]int)
    prefixSum[0] = -1
    sum := 0
    res := 0
    last := -1

    for i, num := range nums {
        sum += num
        if pos, ok := prefixSum[sum - target]; ok && pos >= last {
            res++
            last = i
        }
        prefixSum[sum] = i
    }

    return res
}