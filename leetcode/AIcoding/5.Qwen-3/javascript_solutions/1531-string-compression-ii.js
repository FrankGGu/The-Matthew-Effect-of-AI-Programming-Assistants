function getLengthOfOptimalCompression(s, k) {
    const n = s.length;
    const memo = {};

    function dp(i, deletes) {
        const key = `${i},${deletes}`;
        if (memo[key] !== undefined) return memo[key];
        if (i === n) return 0;
        if (deletes === 0) {
            let res = 0;
            let j = i;
            while (j < n) {
                let count = 0;
                while (j < n && s[j] === s[i]) {
                    j++;
                    count++;
                }
                res += count > 1 ? 1 : 0;
                res += count > 9 ? 2 : count > 1 ? 1 : 0;
                i = j;
            }
            memo[key] = res;
            return res;
        }

        let min = dp(i + 1, deletes - 1);
        let j = i + 1;
        let count = 1;
        while (j < n && s[j] === s[i]) {
            count++;
            j++;
        }
        let cost = 0;
        if (count > 1) cost += 1;
        if (count > 9) cost += 1;
        min = Math.min(min, cost + dp(j, deletes));
        memo[key] = min;
        return min;
    }

    return dp(0, k);
}