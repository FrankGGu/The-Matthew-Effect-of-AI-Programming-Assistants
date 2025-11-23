function matchPlayersAndTrainers(players, trainers) {
    players.sort((a, b) => a - b);
    trainers.sort((a, b) => a - b);

    let playerIndex = 0;
    let trainerIndex = 0;
    let matches = 0;

    while (playerIndex < players.length && trainerIndex < trainers.length) {
        if (players[playerIndex] <= trainers[trainerIndex]) {
            matches++;
            playerIndex++;
            trainerIndex++;
        } else {
            trainerIndex++;
        }
    }

    return matches;
}