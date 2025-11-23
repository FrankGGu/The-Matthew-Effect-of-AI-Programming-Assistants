var getHint = function(secret, guess) {
    let bulls = 0;
    let cows = 0;

    const secretCounts = new Array(10).fill(0);
    const guessCounts = new Array(10).fill(0);

    for (let i = 0; i < secret.length; i++) {
        if (secret[i] === guess[i]) {
            bulls++;
        } else {
            secretCounts[Number(secret[i])]++;
            guessCounts[Number(guess[i])]++;
        }
    }

    for (let i = 0; i < 10; i++) {
        cows += Math.min(secretCounts[i], guessCounts[i]);
    }

    return `${bulls}A${cows}B`;
};