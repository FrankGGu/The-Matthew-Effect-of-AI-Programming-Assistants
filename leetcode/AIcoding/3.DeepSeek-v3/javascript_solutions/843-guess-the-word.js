var findSecretWord = function(wordlist, master) {
    const matchCount = (a, b) => {
        let count = 0;
        for (let i = 0; i < a.length; i++) {
            if (a[i] === b[i]) count++;
        }
        return count;
    };

    for (let i = 0; i < 10; i++) {
        const guess = wordlist[Math.floor(Math.random() * wordlist.length)];
        const matches = master.guess(guess);
        if (matches === 6) return;
        wordlist = wordlist.filter(word => matchCount(word, guess) === matches);
    }
};