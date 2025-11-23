var findTheWinner = function(games, k) {
    let currentWinner = games[0];
    let consecutiveWins = 0;

    for (let i = 0; i < games.length; i++) {
        if (games[i] === currentWinner) {
            consecutiveWins++;
        } else {
            currentWinner = games[i];
            consecutiveWins = 1;
        }

        if (consecutiveWins === k) {
            return currentWinner;
        }
    }

    // According to the problem statement, a winner is guaranteed to be found.
    // This line should theoretically not be reached if a winner is always guaranteed.
    // However, if k is larger than any possible streak in the given 'games' array,
    // and the loop completes without returning, the last player to have a streak
    // (even if it didn't reach k) would be returned.
    // Given the problem implies a winner will be found, the loop will always return.
    return currentWinner; 
};