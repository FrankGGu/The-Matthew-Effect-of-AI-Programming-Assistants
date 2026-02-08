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
        const res = [];
        for (let end = start + 1; end <= s.length; end++) {
            const word = s.substring(start, end);
            if (wordSet.has(word)) {
                const list = backtrack(end);
                for (const str of list) {
                    res.push(word + (str === "" ? "" : " " + str));
                }
            }
        }
        memo.set(start, res);
        return res;
    }

    return backtrack(0);
};