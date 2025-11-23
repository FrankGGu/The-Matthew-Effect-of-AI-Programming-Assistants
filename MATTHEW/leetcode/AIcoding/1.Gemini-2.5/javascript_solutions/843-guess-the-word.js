var findSecretWord = function(wordlist, master) {
    const countMatches = (w1, w2) => {
        let matches = 0;
        for (let i = 0; i < w1.length; i++) {
            if (w1[i] === w2[i]) {
                matches++;
            }
        }
        return matches;
    };

    for (let i = 0; i < 10; i++) {
        const randomIndex = Math.floor(Math.random() * wordlist.length);
        const guessWord = wordlist[randomIndex];

        const matches = master.guess(guessWord);

        if (matches === 6) {
            return;
        }

        const newWordlist = [];
        for (const word of wordlist) {
            if (countMatches(guessWord, word) === matches) {
                newWordlist.push(word);
            }
        }
        wordlist = newWordlist;
    }
};