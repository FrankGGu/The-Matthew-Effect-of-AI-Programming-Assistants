func numberOfPoints(nums [][]int) int {
    // According to the constraints, 1 <= start_i <= end_i <= 100.
    // We can use a boolean array to keep track of all points from 1 to 100.
    // The size 101 allows using indices 1 through