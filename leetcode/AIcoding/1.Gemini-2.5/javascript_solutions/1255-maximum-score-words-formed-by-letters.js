var maxScoreWords = function(words, letters, score) {
    const N = words.length;
    const initialLetterCounts = new Array(26).fill(0);
    for (const char of letters) {
        initialLetterCounts[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    const wordData = [];
    for (const word of words) {
        const counts = new Array(26).fill(0);
        let currentWordScore = 0;
        for (const char of word) {
            const charCode = char.charCodeAt(0) - 'a'.charCodeAt(0);
            counts[charCode]++;
            currentWordScore += score[charCode];
        }
        wordData.push({ counts, score: currentWordScore });
    }

    let maxScore = 0;

    function backtrack(idx, currentLetterCounts, currentTotalScore) {
        if (idx === N) {
            maxScore = Math.max(maxScore, currentTotalScore);
            return;
        }

        // Option 1: Skip the current word (words[idx])
        backtrack(idx + 1, currentLetterCounts, currentTotalScore);

        // Option 2: Try to include the current word (words[idx])
        const { counts: wordCounts, score: wordScore } = wordData[idx];

        let possible = true;
        for (let i = 0; i < 26; i++) {
            if (wordCounts[i] > currentLetterCounts[i]) {
                possible = false;
                break;
            }
        }

        if (possible) {
            const newCounts = [...currentLetterCounts];
            for (let i = 0; i < 26; i++) {
                newCounts[i] -= wordCounts[i];
            }
            backtrack(idx + 1, newCounts, currentTotalScore + wordScore);
        }
    }

    backtrack(0, initialLetterCounts, 0);

    return maxScore;
};