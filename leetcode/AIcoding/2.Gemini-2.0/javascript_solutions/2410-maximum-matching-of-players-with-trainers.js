var matchPlayersAndTrainers = function(players, trainers) {
    players.sort((a, b) => a - b);
    trainers.sort((a, b) => a - b);

    let playerIndex = 0;
    let trainerIndex = 0;
    let count = 0;

    while (playerIndex < players.length && trainerIndex < trainers.length) {
        if (players[playerIndex] <= trainers[trainerIndex]) {
            count++;
            playerIndex++;
            trainerIndex++;
        } else {
            trainerIndex++;
        }
    }

    return count;
};