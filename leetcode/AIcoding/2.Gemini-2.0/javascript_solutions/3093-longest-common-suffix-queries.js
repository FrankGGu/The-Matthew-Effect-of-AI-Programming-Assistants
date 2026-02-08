var longestCommonSuffix = function(s, queries) {
    const n = s.length;
    const result = [];

    for (const query of queries) {
        let left = query[0];
        let right = query[1];
        let count = 0;

        while (left >= 0 && right >= 0 && s[left] === s[right]) {
            count++;
            left--;
            right--;
        }

        result.push(count);
    }

    return result;
};