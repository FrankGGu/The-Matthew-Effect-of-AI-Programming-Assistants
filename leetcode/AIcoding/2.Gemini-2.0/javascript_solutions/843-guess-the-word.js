var findSecretWord = function(wordlist, master) {
    let n = wordlist.length;
    let x = 0;
    for (let i = 0; i < 10; i++) {
        let guess = wordlist[0];
        let match = master.guess(guess);
        if (match === 6) {
            return;
        }
        let newWordlist = [];
        for (let word of wordlist) {
            if (getMatches(guess, word) === match) {
                newWordlist.push(word);
            }
        }
        wordlist = newWordlist;
    }

    function getMatches(word1, word2) {
        let matches = 0;
        for (let i = 0; i < 6; i++) {
            if (word1[i] === word2[i]) {
                matches++;
            }
        }
        return matches;
    }
};