func maxSum(arr [][]int) int {
    maxSum := -63 // Minimum possible sum of an hourglass in a 6x6 grid
    for i := 0; i < len(arr)-2; i++ {
        for j := 0; j < len(arr[i])-2; j++ {
            sum := arr[i][j] + arr[i][j+1] + arr[i][j+2] +
                    arr[i+1][j+1] +
                    arr[i+2][j] + arr[i+2][j+1] + arr[i+2][j+2]
            if sum > maxSum {
                maxSum = sum
            }
        }
    }
    return maxSum
}