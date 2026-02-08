func minimumIncrements(nums []int, k int) int64 {
    var totalIncrements int64 = 0

    for _, num := range nums {
        remainder := num % k
        if remainder != 0 {
            totalIncrements += int64(k - remainder)
        }
    }

    return totalIncrements
}