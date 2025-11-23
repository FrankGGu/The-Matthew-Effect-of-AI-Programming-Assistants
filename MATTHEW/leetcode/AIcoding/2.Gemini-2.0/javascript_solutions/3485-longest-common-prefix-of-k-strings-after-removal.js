var longestCommonPrefixAfterRemoval = function(strs, k) {
    if (!strs || strs.length === 0) {
        return "";
    }

    let n = strs.length;
    let shortestLength = Infinity;
    for (let str of strs) {
        shortestLength = Math.min(shortestLength, str.length);
    }

    let prefix = "";
    for (let i = 0; i < shortestLength; i++) {
        let char = strs[0][i];
        let count = 0;
        for (let j = 0; j < n; j++) {
            if (strs[j][i] === char) {
                count++;
            }
        }

        if (count >= n - k) {
            prefix += char;
        } else {
            break;
        }
    }

    return prefix;
};