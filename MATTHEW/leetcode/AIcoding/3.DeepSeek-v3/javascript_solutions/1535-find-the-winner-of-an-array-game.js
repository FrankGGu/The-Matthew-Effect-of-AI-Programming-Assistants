var getWinner = function(arr, k) {
    let currentWinner = arr[0];
    let winCount = 0;

    for (let i = 1; i < arr.length; i++) {
        if (arr[i] > currentWinner) {
            currentWinner = arr[i];
            winCount = 1;
        } else {
            winCount++;
        }

        if (winCount === k) {
            return currentWinner;
        }
    }

    return currentWinner;
};