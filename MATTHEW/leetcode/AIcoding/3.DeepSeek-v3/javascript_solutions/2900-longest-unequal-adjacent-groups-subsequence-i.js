var getWordsInLongestSubsequence = function(n, words, groups) {
    let result = [];
    let prevGroup = -1;
    for (let i = 0; i < n; i++) {
        if (groups[i] !== prevGroup) {
            result.push(words[i]);
            prevGroup = groups[i];
        }
    }
    return result;
};