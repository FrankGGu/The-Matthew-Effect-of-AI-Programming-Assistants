function maxScoreWords(words, letters) {
    const count = new Array(26).fill(0);
    for (const c of letters) {
        count[c.charCodeAt(0) - 97]++;
    }

    const wordCounts = [];
    for (const word of words) {
        const wc = new Array(26).fill(0);
        for (const c of word) {
            wc[c.charCodeAt(0) - 97]++;
        }
        wordCounts.push(wc);
    }

    let maxScore = 0;

    function backtrack(index, currentCount) {
        if (index === words.length) {
            let score = 0;
            for (let i = 0; i < 26; i++) {
                score += currentCount[i] * (i + 1);
            }
            maxScore = Math.max(maxScore, score);
            return;
        }

        // Skip the current word
        backtrack(index + 1, currentCount);

        // Try to include the current word
        const word = wordCounts[index];
        let canAdd = true;
        for (let i = 0; i < 26; i++) {
            if (currentCount[i] + word[i] > count[i]) {
                canAdd = false;
                break;
            }
        }

        if (canAdd) {
            for (let i = 0; i < 26; i++) {
                currentCount[i] += word[i];
            }
            backtrack(index + 1, currentCount);
            for (let i = 0; i < 26; i++) {
                currentCount[i] -= word[i];
            }
        }
    }

    backtrack(0, new Array(26).fill(0));
    return maxScore;
}