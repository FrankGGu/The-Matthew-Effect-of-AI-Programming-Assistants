function getWinner(arr, k) {
    let max = arr[0];
    let count = 0;

    for (let i = 1; i < arr.length; i++) {
        if (arr[i] > max) {
            max = arr[i];
            count = 1;
        } else {
            count++;
        }

        if (count === k) {
            return max;
        }
    }

    return max;
}