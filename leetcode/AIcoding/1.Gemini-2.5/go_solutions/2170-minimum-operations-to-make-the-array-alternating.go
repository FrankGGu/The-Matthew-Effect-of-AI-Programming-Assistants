func minimumOperations(nums []int) int {
    n := len(nums)
    if n <= 1 {
        return 0
    }

    evenCounts := make(map[int]int)
    oddCounts := make(map[int]int)

    for i, num := range nums {
        if i%2