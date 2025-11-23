var countSubstrings = function(s, k) {
    let n = s.length;
    let ans = 0;

    for (let i = 0; i < n; i++) {
        let count = 0;
        let freq = new Array(26).fill(0);
        for (let j = i; j < n; j++) {
            let charCode = s.charCodeAt(j) - 'a'.charCodeAt(0);
            if (freq[charCode] === 0) {
                count++;
            }
            freq[charCode]++;

            if (count <= k) {
                ans++;
            }
        }
    }

    return ans;
};