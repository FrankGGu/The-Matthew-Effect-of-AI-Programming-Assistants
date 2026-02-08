var beautifulSubstrings = function(s, k) {
    let n = s.length;
    let ans = 0;
    for (let i = 0; i < n; i++) {
        let v = 0, c = 0;
        for (let j = i; j < n; j++) {
            if (s[j] == 'a' || s[j] == 'e' || s[j] == 'i' || s[j] == 'o' || s[j] == 'u') {
                v++;
            } else {
                c++;
            }
            if (v == c && (v * c) % k == 0) {
                ans++;
            }
        }
    }
    return ans;
};