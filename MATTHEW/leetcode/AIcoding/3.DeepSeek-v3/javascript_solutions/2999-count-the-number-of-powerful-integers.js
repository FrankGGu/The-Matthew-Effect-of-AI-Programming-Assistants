var numberOfPowerfulInt = function(start, finish, limit, s) {
    const sLen = s.length;
    const sNum = parseInt(s, 10);
    const memo = {};

    function dfs(pos, tight, isLeadingZero, numStr) {
        if (pos === numStr.length) {
            if (!isLeadingZero) {
                const suffix = numStr.slice(numStr.length - sLen);
                return suffix === s ? 1 : 0;
            }
            return 0;
        }
        const key = `${pos}_${tight}_${isLeadingZero}`;
        if (memo[key] !== undefined) return memo[key];

        let maxDigit = tight ? parseInt(numStr[pos], 10) : 9;
        maxDigit = Math.min(maxDigit, limit);
        let res = 0;

        for (let d = 0; d <= maxDigit; d++) {
            const newTight = tight && (d === parseInt(numStr[pos], 10));
            const newLeadingZero = isLeadingZero && (d === 0);
            let newNumStr = numStr;
            if (!newLeadingZero) {
                newNumStr = numStr.substring(0, pos) + d.toString() + numStr.substring(pos + 1);
            }
            res += dfs(pos + 1, newTight, newLeadingZero, newNumStr);
        }

        memo[key] = res;
        return res;
    }

    function countUpTo(x) {
        const xStr = x.toString();
        memo = {};
        return dfs(0, true, true, xStr);
    }

    return countUpTo(finish) - countUpTo(start - 1);
};