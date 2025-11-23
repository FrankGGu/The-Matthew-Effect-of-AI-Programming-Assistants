var getWordsInLongestSubsequence = function(n, words, groups) {
    let dp = new Array(n).fill(1);
    let prev = new Array(n).fill(-1);

    for (let i = 1; i < n; i++) {
        for (let j = 0; j < i; j++) {
            if (groups[i] !== groups[j] && words[i].length === words[j].length) {
                let isHammingValid = true;
                for (let k = 0; k < words[i].length; k++) {
                    if (words[i][k] === words[j][k]) {
                        isHammingValid = false;
                        break;
                    }
                }
                if (isHammingValid && dp[i] < dp[j] + 1) {
                    dp[i] = dp[j] + 1;
                    prev[i] = j;
                }
            }
        }
    }

    let maxLen = Math.max(...dp);
    let index = dp.indexOf(maxLen);
    let result = [];

    while (index !== -1) {
        result.unshift(words[index]);
        index = prev[index];
    }

    return result;
};