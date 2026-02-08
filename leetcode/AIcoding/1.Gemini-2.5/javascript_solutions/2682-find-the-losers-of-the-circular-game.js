var circularGameLosers = function(n) {
    const receivedBall = new Set();
    let currentPlayer = 1;
    let round = 1;

    receivedBall.add(currentPlayer);

    while (true) {
        let nextPlayer = (currentPlayer - 1 + round) % n + 1;

        if (receivedBall.has(nextPlayer)) {
            break; 
        }

        receivedBall.add(nextPlayer);
        currentPlayer = nextPlayer;
        round++;
    }

    const losers = [];
    for (let i = 1; i <= n; i++) {
        if (!receivedBall.has(i)) {
            losers.push(i);
        }
    }

    return losers;
};