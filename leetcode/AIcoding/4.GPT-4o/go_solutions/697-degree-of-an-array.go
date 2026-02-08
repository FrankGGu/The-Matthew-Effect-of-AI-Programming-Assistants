func findShortestSubarray(nums []int) int {
    left, right := make(map[int]int), make(map[int]int)
    for i, num := range nums {
        if _, ok := left[num]; !ok {
            left[num] = i
        }
        right[num] = i
    }

    degree := 0
    for _, count := range left {
        if count > degree {
            degree = count
        }
    }

    minLength := len(nums)
    for num, l := range left {
        if right[num]-l+1 == degree {
            length := right[num] - l + 1
            if length < minLength {
                minLength = length
            }
        }
    }

    return minLength
}