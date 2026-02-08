function getWinner(arr, k) {
    let max = arr[0];
    for (let i = 1; i < arr.length; i++) {
        if (arr[i] > max) {
            max = arr[i];
        }
        if (max === arr[i]) {
            return max;
        }
    }
    return max;
}