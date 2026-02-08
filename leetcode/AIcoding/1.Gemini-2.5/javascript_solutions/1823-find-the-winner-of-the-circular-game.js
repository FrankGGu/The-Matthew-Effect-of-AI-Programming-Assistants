var findTheWinner = function(n, k) {
    let winnerIndex = 0; 

    for (let i = 2; i <= n; i++) {
        winnerIndex = (winnerIndex + k) % i;
    }

    return winnerIndex + 1;
};