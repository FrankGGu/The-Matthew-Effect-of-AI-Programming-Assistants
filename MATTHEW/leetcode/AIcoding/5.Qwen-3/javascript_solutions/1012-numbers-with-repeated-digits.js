function numDupDigitsIntegers(n) {
    const digits = [];
    let m = n;
    while (m > 0) {
        digits.push(m % 10);
        m = Math.floor(m / 10);
    }
    const len = digits.length;
    const used = new Array(10).fill(false);
    let result = 0;

    function dfs(pos, tight, leading, used) {
        if (pos === len) {
            return 1;
        }
        let res = 0;
        const limit = tight ? digits[len - pos - 1] : 9;
        for (let d = 0; d <= limit; d++) {
            const newTight = tight && (d === limit);
            const newLeading = leading && (d === 0);
            const newUsed = used.slice();
            if (!newLeading && !newUsed[d]) {
                newUsed[d] = true;
                res += dfs(pos + 1, newTight, newLeading, newUsed);
            } else if (newLeading) {
                res += dfs(pos + 1, newTight, newLeading, newUsed);
            }
        }
        return res;
    }

    for (let i = 1; i < len; i++) {
        let count = 9;
        let available = 9;
        for (let j = 1; j < i; j++) {
            count *= available;
            available--;
        }
        result += count;
    }

    result += dfs(0, true, true, used);
    return n - result + 1;
}