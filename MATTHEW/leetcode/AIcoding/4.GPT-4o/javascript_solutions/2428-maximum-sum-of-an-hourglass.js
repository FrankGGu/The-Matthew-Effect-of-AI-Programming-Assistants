var maxSum = function(arr) {
    let max = -63; // Minimum possible hourglass sum
    for (let i = 0; i < arr.length - 2; i++) {
        for (let j = 0; j < arr[i].length - 2; j++) {
            let hourglassSum = arr[i][j] + arr[i][j + 1] + arr[i][j + 2] +
                               arr[i + 1][j + 1] +
                               arr[i + 2][j] + arr[i + 2][j + 1] + arr[i + 2][j + 2];
            max = Math.max(max, hourglassSum);
        }
    }
    return max;
};