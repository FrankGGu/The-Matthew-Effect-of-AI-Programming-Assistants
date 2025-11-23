var maxScoreWords = function(words, letters, score) {
    const letterCount = new Array(26).fill(0);
    for (const letter of letters) {
        letterCount[letter.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    let maxScore = 0;

    const backtrack = (index, currentScore, currentCount) => {
        if (index === words.length) {
            maxScore = Math.max(maxScore, currentScore);
            return;
        }

        backtrack(index + 1, currentScore, [...currentCount]);

        const word = words[index];
        let tempCount = [...currentCount];
        let wordScore = 0;
        let canForm = true;

        for (const char of word) {
            const idx = char.charCodeAt(0) - 'a'.charCodeAt(0);
            if (tempCount[idx] === 0) {
                canForm = false;
                break;
            }
            tempCount[idx]--;
            wordScore += score[idx];
        }

        if (canForm) {
            backtrack(index + 1, currentScore + wordScore, tempCount);
        }
    };

    backtrack(0, 0, letterCount);

    return maxScore;
};