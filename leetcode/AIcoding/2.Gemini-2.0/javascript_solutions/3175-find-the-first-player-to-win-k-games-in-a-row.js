var getWinner = function(arr, k) {
    let winner = arr[0];
    let winCount = 0;
    for (let i = 1; i < arr.length; i++) {
        if (winner > arr[i]) {
            winCount++;
        } else {
            winner = arr[i];
            winCount = 1;
        }
        if (winCount === k) {
            return winner;
        }
    }
    return winner;
};