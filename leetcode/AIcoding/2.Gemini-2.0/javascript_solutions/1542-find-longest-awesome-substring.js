var longestAwesome = function(s) {
    let n = s.length;
    let first = new Array(1024).fill(n);
    first[0] = -1;
    let ans = 0;
    let mask = 0;

    for (let i = 0; i < n; i++) {
        mask ^= (1 << (s.charCodeAt(i) - '0'.charCodeAt(0)));

        if (first[mask] === n) {
            first[mask] = i;
        }

        ans = Math.max(ans, i - first[mask]);

        for (let j = 0; j < 10; j++) {
            let tempMask = mask ^ (1 << j);
            if (first[tempMask] !== n) {
                ans = Math.max(ans, i - first[tempMask]);
            }
        }
    }

    return ans;
};