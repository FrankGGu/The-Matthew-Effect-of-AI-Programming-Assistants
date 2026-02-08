var numberOfBeautifulIntegers = function(low, high, k) {
    const memo = new Map();

    function dfs(pos, tight, isLeadingZero, evenMinusOdd, mod, digits, target) {
        if (pos === target.length) {
            return !isLeadingZero && evenMinusOdd === 0 && mod === 0 ? 1 : 0;
        }
        const key = `${pos}_${tight}_${isLeadingZero}_${evenMinusOdd}_${mod}`;
        if (memo.has(key)) return memo.get(key);

        let limit = tight ? parseInt(target[pos]) : 9;
        let total = 0;

        for (let d = 0; d <= limit; d++) {
            const newTight = tight && (d === limit);
            const newLeadingZero = isLeadingZero && (d === 0);
            let newEvenMinusOdd = evenMinusOdd;
            let newMod = (mod * 10 + d) % k;

            if (!newLeadingZero) {
                if (d % 2 === 0) {
                    newEvenMinusOdd++;
                } else {
                    newEvenMinusOdd--;
                }
            }

            total += dfs(pos + 1, newTight, newLeadingZero, newEvenMinusOdd, newMod, digits, target);
        }

        memo.set(key, total);
        return total;
    }

    function countUpTo(n) {
        const s = n.toString();
        memo.clear();
        return dfs(0, true, true, 0, 0, s, s);
    }

    return countUpTo(high) - countUpTo(low - 1);
};