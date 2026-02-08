function vowelsGame(s) {
    const vowels = new Set('aeiou');
    let player1Score = 0;
    let player2Score = 0;

    for (let char of s) {
        if (vowels.has(char)) {
            player1Score++;
        } else {
            player2Score++;
        }
    }

    if (player1Score > player2Score) {
        return "Player 1";
    } else if (player2Score > player1Score) {
        return "Player 2";
    } else {
        return "Draw";
    }
}