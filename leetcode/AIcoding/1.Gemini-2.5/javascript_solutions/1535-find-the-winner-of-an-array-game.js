var getWinner = function(arr, k) {
    if (k === 0) {
        return arr[0];
    }

    if (k >= arr.length - 1) {
        return Math.max(...arr);
    }

    let currentWinner = arr[0];
    let consecutiveWins = 0;

    for (let i = 1; i < arr.length; i++) {
        let challenger = arr[i];

        if (currentWinner > challenger) {
            consecutiveWins++;
        } else {
            currentWinner = challenger;
            consecutiveWins = 1;
        }

        if (consecutiveWins === k) {
            return currentWinner;
        }
    }

    return currentWinner;
};