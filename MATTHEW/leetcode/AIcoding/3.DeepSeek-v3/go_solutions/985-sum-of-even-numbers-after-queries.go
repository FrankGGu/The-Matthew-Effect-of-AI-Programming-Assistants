func sumEvenAfterQueries(nums []int, queries [][]int) []int {
    sum := 0
    for _, num := range nums {
        if num%2 == 0 {
            sum += num
        }
    }

    res := make([]int, len(queries))
    for i, query := range queries {
        val, index := query[0], query[1]
        old := nums[index]
        if old%2 == 0 {
            sum -= old
        }
        nums[index] += val
        if nums[index]%2 == 0 {
            sum += nums[index]
        }
        res[i] = sum
    }
    return res
}