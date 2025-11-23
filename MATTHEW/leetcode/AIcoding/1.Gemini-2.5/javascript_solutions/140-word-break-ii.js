var wordBreak = function(s, wordDict) {
    const dict = new Set(wordDict);
    const memo = new Map();

    function backtrack(startIndex) {
        if (memo.has(startIndex)) {
            return memo.get(startIndex);
        }

        if (startIndex === s.length) {
            return [""];
        }

        const results = [];
        for (let i = startIndex; i < s.length; i++) {
            const word = s.substring(startIndex, i + 1);
            if (dict.has(word)) {
                const subSentences = backtrack(i + 1);
                for (const subSentence of subSentences) {
                    if (subSentence === "") {
                        results.push(word);
                    } else {
                        results.push(word + " " + subSentence);
                    }
                }
            }
        }

        memo.set(startIndex, results);
        return results;
    }

    return backtrack(0);
};