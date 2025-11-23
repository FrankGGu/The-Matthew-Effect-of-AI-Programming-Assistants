function longestCommonPrefix(strs) {
    if (!strs.length) return "";

    let minLen = Math.min(...strs.map(s => s.length));

    for (let i = 0; i < minLen; i++) {
        const char = strs[0][i];
        for (let j = 1; j < strs.length; j++) {
            if (strs[j][i] !== char) {
                return strs[0].slice(0, i);
            }
        }
    }
    return strs[0].slice(0, minLen);
}

function longestCommonPrefixAfterRemoval(strs) {
    const n = strs.length;
    let longestPrefix = longestCommonPrefix(strs);

    if (longestPrefix === "") return "";

    let maxPrefixLength = longestPrefix.length;

    for (let i = 0; i < n; i++) {
        const remainingStrs = strs.slice(0, i).concat(strs.slice(i + 1));
        const prefix = longestCommonPrefix(remainingStrs);
        maxPrefixLength = Math.max(maxPrefixLength, prefix.length);
    }

    return longestPrefix.slice(0, maxPrefixLength);
}