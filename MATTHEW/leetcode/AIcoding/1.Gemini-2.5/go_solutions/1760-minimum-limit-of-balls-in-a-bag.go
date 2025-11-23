func minimumLimit(nums []int, maxOperations int) int {
    low := 1
    high := 0
    for _, num := range nums {
        if num > high {
            high = num
        }
    }

    ans := high // Initialize answer with a valid upper bound

    for low <= high