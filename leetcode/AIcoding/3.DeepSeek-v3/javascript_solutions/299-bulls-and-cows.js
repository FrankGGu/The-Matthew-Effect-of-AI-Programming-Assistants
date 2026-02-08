var getHint = function(secret, guess) {
    let bulls = 0;
    let cows = 0;
    const secretCount = {};
    const guessCount = {};

    for (let i = 0; i < secret.length; i++) {
        if (secret[i] === guess[i]) {
            bulls++;
        } else {
            secretCount[secret[i]] = (secretCount[secret[i]] || 0) + 1;
            guessCount[guess[i]] = (guessCount[guess[i]] || 0) + 1;
        }
    }

    for (let key in secretCount) {
        if (guessCount[key]) {
            cows += Math.min(secretCount[key], guessCount[key]);
        }
    }

    return `${bulls}A${cows}B`;
};