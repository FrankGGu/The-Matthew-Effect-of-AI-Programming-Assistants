var longestSubsequence = function(s, k) {
    let res = 0;
    let cost = 1;
    for (let i = s.length - 1; i >= 0; i--) {
        if (s[i] === '0') {
            res++;
        } else if (cost <= k) {
            k -= cost;
            res++;
        }
        cost *= 2;
        if (cost > k) {
            break;
        }
    }
    return res;
};