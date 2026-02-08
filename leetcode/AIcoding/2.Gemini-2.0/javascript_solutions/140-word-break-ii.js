var wordBreak = function(s, wordDict) {
    const wordSet = new Set(wordDict);
    const memo = new Map();

    function backtrack(start) {
        if (memo.has(start)) {
            return memo.get(start);
        }

        if (start === s.length) {
            return [""];
        }

        const result = [];
        for (let end = start + 1; end <= s.length; end++) {
            const word = s.substring(start, end);
            if (wordSet.has(word)) {
                const nextSentences = backtrack(end);
                for (const sentence of nextSentences) {
                    result.push(word + (sentence === "" ? "" : " ") + sentence);
                }
            }
        }

        memo.set(start, result);
        return result;
    }

    return backtrack(0);
};