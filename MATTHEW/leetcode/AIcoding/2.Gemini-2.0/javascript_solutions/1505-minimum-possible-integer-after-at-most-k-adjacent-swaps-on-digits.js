var minInteger = function(num, k) {
    const n = num.length;
    const pos = Array(10).fill(null).map(() => []);
    for (let i = 0; i < n; i++) {
        pos[parseInt(num[i])].push(i);
    }

    const bit = Array(n + 1).fill(0);

    function update(i, val) {
        while (i <= n) {
            bit[i] += val;
            i += (i & -i);
        }
    }

    function query(i) {
        let sum = 0;
        while (i > 0) {
            sum += bit[i];
            i -= (i & -i);
        }
        return sum;
    }

    let ans = "";
    for (let i = 0; i < n; i++) {
        for (let d = 0; d < 10; d++) {
            if (pos[d].length > 0) {
                const originalIndex = pos[d][0];
                const shiftedIndex = originalIndex - query(originalIndex + 1);
                if (shiftedIndex <= k) {
                    ans += d;
                    k -= shiftedIndex;
                    pos[d].shift();
                    update(originalIndex + 1, 1);
                    break;
                }
            }
        }
    }

    return ans;
};