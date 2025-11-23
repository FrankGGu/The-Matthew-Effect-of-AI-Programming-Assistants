function winnerOfGame(sessionString) {
    let count = 0;
    for (let i = 1; i < sessionString.length - 1; i++) {
        if (sessionString[i] === sessionString[i - 1] && sessionString[i] === sessionString[i + 1]) {
            count++;
        }
    }
    return count > 0;
}