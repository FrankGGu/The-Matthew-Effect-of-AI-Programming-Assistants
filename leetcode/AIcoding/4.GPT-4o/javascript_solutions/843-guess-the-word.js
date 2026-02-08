class Master {
    guess(word) {
        // Implementation not provided by LeetCode.
    }
}

var findSecretWord = function(wordlist, master) {
    const getMatchCount = (a, b) => {
        let count = 0;
        for (let i = 0; i < a.length; i++) {
            if (a[i] === b[i]) count++;
        }
        return count;
    };

    let remainingWords = wordlist.slice();
    for (let i = 0; i < 10; i++) {
        const guess = remainingWords[Math.floor(Math.random() * remainingWords.length)];
        const matchCount = master.guess(guess);

        if (matchCount === 6) return; // Found the secret word

        remainingWords = remainingWords.filter(word => getMatchCount(guess, word) === matchCount);
    }
};