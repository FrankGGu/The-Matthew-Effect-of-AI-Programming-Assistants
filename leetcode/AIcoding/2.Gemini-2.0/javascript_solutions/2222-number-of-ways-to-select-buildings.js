var numberOfWays = function(s) {
    let n = s.length;
    let ans = 0;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            for (let k = j + 1; k < n; k++) {
                if (s[i] !== s[j] && s[j] !== s[k]) {
                    ans++;
                }
            }
        }
    }

    return ans;
};