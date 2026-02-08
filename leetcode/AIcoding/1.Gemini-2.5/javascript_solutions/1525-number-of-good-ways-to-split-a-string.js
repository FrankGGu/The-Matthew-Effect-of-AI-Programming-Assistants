var numSplits = function(s) {
    const n = s.length;

    const prefixDistinct = new Array(n);
    const suffixDistinct = new Array(n);

    const prefixSet = new Set();
    for (let i = 0; i < n; i++) {
        prefixSet.add(s[i]);
        prefixDistinct[i] = prefixSet.size;
    }

    const suffixSet = new Set();
    for (let i = n - 1; i >= 0; i--) {
        suffixSet.add(s[i]);
        suffixDistinct[i] = suffixSet.size;
    }

    let goodWays = 0;
    for (let i = 0; i < n - 1; i++) {
        if (prefixDistinct[i] === suffixDistinct[i + 1]) {
            goodWays++;
        }
    }

    return goodWays;
};