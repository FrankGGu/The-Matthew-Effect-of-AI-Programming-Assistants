var wordBreak = function(s, wordDict) {
    const memo = {};
    const backtrack = (start) => {
        if (start === s.length) return [''];
        if (memo[start]) return memo[start];

        const result = [];
        for (let end = start + 1; end <= s.length; end++) {
            const word = s.slice(start, end);
            if (wordDict.includes(word)) {
                const sublist = backtrack(end);
                for (let sub of sublist) {
                    result.push(word + (sub ? ' ' + sub : ''));
                }
            }
        }

        memo[start] = result;
        return result;
    };

    return backtrack(0);
};