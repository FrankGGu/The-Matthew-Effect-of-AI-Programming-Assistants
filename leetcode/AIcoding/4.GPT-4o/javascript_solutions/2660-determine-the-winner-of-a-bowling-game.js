function bowlingGame(winner, loser) {
    let scoreA = 0, scoreB = 0;

    for (let i = 0; i < winner.length; i++) {
        scoreA += parseInt(winner[i]);
        scoreB += parseInt(loser[i]);
    }

    return scoreA > scoreB ? 'Winner' : 'Loser';
}