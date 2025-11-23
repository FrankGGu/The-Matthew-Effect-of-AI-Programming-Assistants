var losingPlayer = function(x, y) {
    let maxTurns = 0;

    // Iterate through all possible counts of Move 1 (take 1x, 2y).
    // Let k1 be the number of times Move 1 is chosen.
    // For k1 moves of type 1:
    // - We need k1 * 1 <= x, so k1 <= x.
    // - We need k1 * 2 <= y, so k1 <= y / 2.
    // Thus, k1 can range from 0 up to Math.min(x, Math.floor(y / 2)).
    for (let k1 = 0; k1 <= x && k1 * 2 <= y; k1++) {
        // Calculate remaining coins after making k1 moves of type 1.
        const remainingX = x - k1;
        const remainingY = y - 2 * k1;

        // From the remaining coins, we can only make Move 2 (take 2x, 1y).
        // Let k2 be the number of times Move 2 is chosen from the remaining coins.
        // - We need k2 * 2 <= remainingX, so k2 <= remainingX / 2.
        // - We need k2 * 1 <= remainingY, so k2 <= remainingY.
        // Thus, k2 is limited by Math.min(Math.floor(remainingX / 2), remainingY).
        const k2 = Math.min(Math.floor(remainingX / 2), remainingY);

        // The total number of turns for this combination of k1 and k2 is k1 + k2.
        // We want to find the maximum possible total turns.
        maxTurns = Math.max(maxTurns, k1 + k2);
    }

    // In this type of impartial game, the player who makes the last move wins.
    // Alice goes first.
    // If the total number of moves (maxTurns) is odd, Alice makes the last move and wins.
    // If the total number of moves (maxTurns) is even, Bob makes the last move and wins.
    if (maxTurns % 2 === 1) {
        return "Alice";
    } else {
        return "Bob";
    }
};