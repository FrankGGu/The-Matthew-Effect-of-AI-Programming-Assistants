var longestCommonPrefix = function(strs, k) {
    if (strs.length === 0) return "";
    if (strs.length <= k) return "";

    let prefix = strs[0];

    for (let i = 1; i < strs.length; i++) {
        while (strs[i].indexOf(prefix) !== 0) {
            prefix = prefix.substring(0, prefix.length - 1);
            if (prefix === "") return "";
        }
    }

    const sorted = strs.map(s => s.length).sort((a, b) => a - b);
    const minLen = sorted[Math.min(k, sorted.length - 1)];

    return prefix.substring(0, minLen);
};