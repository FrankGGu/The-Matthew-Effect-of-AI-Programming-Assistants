var maxScoreWords = function(words, scores) {
    const n = words.length;
    let maxScore = 0;

    const getCharCount = (word) => {
        const count = Array(26).fill(0);
        for (const char of word) {
            count[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
        }
        return count;
    };

    const backtrack = (index, currentCount, currentScore) => {
        if (index === n) {
            maxScore = Math.max(maxScore, currentScore);
            return;
        }

        backtrack(index + 1, currentCount, currentScore);

        const wordCount = getCharCount(words[index]);
        let valid = true;
        let newCount = [...currentCount];
        let wordScore = 0;

        for (let i = 0; i < 26; i++) {
            if (wordCount[i] > 0) {
                newCount[i] += wordCount[i];
                if (newCount[i] > 0) {
                    wordScore += wordCount[i] * scores[i];
                }
            }
        }

        if (valid) {
            backtrack(index + 1, newCount, currentScore + wordScore);
        }
    };

    backtrack(0, Array(26).fill(0), 0);
    return maxScore;
};