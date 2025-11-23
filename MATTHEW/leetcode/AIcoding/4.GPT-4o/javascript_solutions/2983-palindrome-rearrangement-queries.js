var canMakePaliQueries = function(s, queries) {
    const count = new Array(26).fill(0);
    for (const char of s) {
        count[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    const oddCount = count.filter(x => x % 2 === 1).length;

    return queries.map(([left, right, k]) => {
        const length = right - left + 1;
        const oddNeeded = Math.max(0, oddCount - (length % 2 === 0 ? 0 : 1));
        return k >= oddNeeded;
    });
};