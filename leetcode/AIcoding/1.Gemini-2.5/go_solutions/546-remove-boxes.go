func removeBoxes(boxes []int) int {
    n := len(boxes)
    // dp[i][j][k] stores the maximum points for the subsegment boxes[i...j]
    // assuming there are k boxes identical to boxes[j] immediately to its right.
    // Initialize with -1 to indicate