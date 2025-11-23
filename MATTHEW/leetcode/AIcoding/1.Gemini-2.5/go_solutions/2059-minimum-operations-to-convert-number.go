func minimumOperations(nums []int, start int, target int) int {
    if start == target {
        return 0
    }

    queue := make([][2]int, 0) // [current_number, steps]
    queue = append(queue, [2]int{start, 0})

    // visited