var canConvert = function(s, t, k) {
    if (s.length !== t.length) return false;

    let diff = new Array(26).fill(0);

    for (let i = 0; i < s.length; i++) {
        if (s[i] !== t[i]) {
            diff[s.charCodeAt(i) - 'a'.charCodeAt(0)]++;
            diff[t.charCodeAt(i) - 'a'.charCodeAt(0)]--;
        }
    }

    let totalDiff = diff.reduce((acc, count) => acc + Math.abs(count), 0);

    return totalDiff <= k && (totalDiff % 2 === k % 2 || totalDiff < 26);
};