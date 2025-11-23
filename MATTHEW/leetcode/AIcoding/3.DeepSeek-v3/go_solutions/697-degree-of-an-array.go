func findShortestSubArray(nums []int) int {
    left := make(map[int]int)
    right := make(map[int]int)
    count := make(map[int]int)

    for i, num := range nums {
        if _, ok := left[num]; !ok {
            left[num] = i
        }
        right[num] = i
        count[num]++
    }

    maxCount := 0
    for _, v := range count {
        if v > maxCount {
            maxCount = v
        }
    }

    minLength := len(nums)
    for num, cnt := range count {
        if cnt == maxCount {
            length := right[num] - left[num] + 1
            if length < minLength {
                minLength = length
            }
        }
    }

    return minLength
}