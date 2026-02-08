var maxScoreWords = function(words, letters, score) {
    let letterCount = {};
    for (let letter of letters) {
        letterCount[letter] = (letterCount[letter] || 0) + 1;
    }

    let maxScore = 0;

    function backtrack(index, currentScore, currentLetterCount) {
        if (index === words.length) {
            maxScore = Math.max(maxScore, currentScore);
            return;
        }

        backtrack(index + 1, currentScore, {...currentLetterCount});

        let word = words[index];
        let wordScore = 0;
        let newLetterCount = {...currentLetterCount};
        let possible = true;

        for (let char of word) {
            if (!newLetterCount[char] || newLetterCount[char] === 0) {
                possible = false;
                break;
            }
            newLetterCount[char]--;
            wordScore += score[char.charCodeAt(0) - 'a'.charCodeAt(0)];
        }

        if (possible) {
            backtrack(index + 1, currentScore + wordScore, newLetterCount);
        }
    }

    backtrack(0, 0, letterCount);
    return maxScore;
};