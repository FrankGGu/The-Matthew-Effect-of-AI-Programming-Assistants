var countKSubsequencesWithMaxBeauty = function(s, k) {
    const MOD = 1000000007;
    const freq = new Array(26).fill(0);
    for (const char of s) {
        freq[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }
    freq.sort((a, b) => b - a);
    const arr = freq.filter(x => x > 0);

    const n = arr.length;
    let minVal = arr[k - 1];
    let countOfMinVal = 0;
    let countOfMinValInArr = 0;
    for (let i = 0; i < 26; i++) {
        if (freq[i] === minVal) {
            countOfMinVal++;
        }
    }
    for (let i = 0; i < n; i++) {
        if (arr[i] === minVal) {
            countOfMinValInArr++;
        }
    }

    function combinations(n, r) {
        if (r < 0 || r > n) {
            return 0;
        }
        if (r === 0 || r === n) {
            return 1;
        }
        if (r > n / 2) {
            r = n - r;
        }
        let res = 1;
        for (let i = 1; i <= r; i++) {
            res = (res * (n - i + 1)) / i;
        }
        return res;
    }

    return combinations(countOfMinValInArr, k - (n - countOfMinValInArr)) % MOD;
};