var balancedString = function(s) {
    const n = s.length;
    const k = n / 4;
    const count = { Q: 0, W: 0, E: 0, R: 0 };
    for (const char of s) {
        count[char]++;
    }

    let l = 0;
    let ans = n;
    for (let r = 0; r < n; r++) {
        count[s[r]]--;
        while (count['Q'] <= k && count['W'] <= k && count['E'] <= k && count['R'] <= k) {
            ans = Math.min(ans, r - l + 1);
            count[s[l]]++;
            l++;
        }
    }

    return ans;
};