var getHint = function(secret, guess) {
    let bulls = 0;
    let cows = 0;
    const secretCounts = {};
    const guessCounts = {};

    for (let i = 0; i < secret.length; i++) {
        if (secret[i] === guess[i]) {
            bulls++;
        } else {
            if (secretCounts[secret[i]]) {
                secretCounts[secret[i]]++;
            } else {
                secretCounts[secret[i]] = 1;
            }

            if (guessCounts[guess[i]]) {
                guessCounts[guess[i]]++;
            } else {
                guessCounts[guess[i]] = 1;
            }
        }
    }

    for (const digit in guessCounts) {
        if (secretCounts[digit]) {
            cows += Math.min(secretCounts[digit], guessCounts[digit]);
        }
    }

    return `${bulls}A${cows}B`;
};