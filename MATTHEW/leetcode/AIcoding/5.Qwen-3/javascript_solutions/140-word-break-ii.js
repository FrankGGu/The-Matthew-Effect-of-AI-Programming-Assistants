function wordBreak(s, wordDict) {
    const memo = {};

    function helper(s) {
        if (memo.hasOwnProperty(s)) return memo[s];
        if (s === "") return [""];

        const result = [];

        for (const word of wordDict) {
            if (s.startsWith(word)) {
                const subResults = helper(s.substring(word.length));
                for (const subResult of subResults) {
                    result.push(word + (subResult ? " " + subResult : ""));
                }
            }
        }

        memo[s] = result;
        return result;
    }

    return helper(s);
}