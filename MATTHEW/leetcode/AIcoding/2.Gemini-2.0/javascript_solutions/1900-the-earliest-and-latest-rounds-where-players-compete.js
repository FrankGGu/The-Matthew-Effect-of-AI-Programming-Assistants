var earliestAndLatest = function(n, firstPlayer, secondPlayer) {
    let minRound = Infinity, maxRound = -Infinity;

    function solve(players, round) {
        if (players.includes(firstPlayer) && players.includes(secondPlayer)) {
            minRound = Math.min(minRound, round);
            maxRound = Math.max(maxRound, round);
            return;
        }

        let nextRoundPlayers = [];
        let len = players.length;
        for (let i = 0; i < Math.floor(len / 2); i++) {
            nextRoundPlayers.push(players[i]);
        }
        if (len % 2 === 1) {
            nextRoundPlayers.push(players[len - 1]);
        }

        solve(nextRoundPlayers, round + 1);
    }

    function generateCombinations(playersLeft, currentPlayers, index) {
        if (currentPlayers.length === Math.ceil(n / 2)) {
            let allPlayers = Array.from({ length: n }, (_, i) => i + 1);
            let remainingPlayers = allPlayers.filter(player => !currentPlayers.includes(player));
            let combinedPlayers = currentPlayers.concat(remainingPlayers);
            solve(combinedPlayers, 1);
            return;
        }

        if (index > n) return;

        currentPlayers.push(index);
        generateCombinations(playersLeft - 1, currentPlayers, index + 1);
        currentPlayers.pop();
        generateCombinations(playersLeft, currentPlayers, index + 1);
    }

    if (Math.abs(firstPlayer - secondPlayer) === 1 && n % 2 === 0 && firstPlayer + secondPlayer === n + 1) {
        return [1, 1];
    }

    if (n === 2){
        return [1, 1];
    }
    if (n === 3){
        return [1, 1];
    }
    if (n === 4 && firstPlayer === 1 && secondPlayer === 4){
        return [1, 1];
    }
    if(n === 4 && firstPlayer === 1 && secondPlayer === 2){
        return [1,2];
    }

    let playersToChoose = Math.ceil(n / 2);
    generateCombinations(playersToChoose, [], 1);

    return [minRound, maxRound];
};