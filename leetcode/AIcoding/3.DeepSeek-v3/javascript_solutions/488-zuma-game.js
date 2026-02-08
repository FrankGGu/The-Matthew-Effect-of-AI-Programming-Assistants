var findMinStep = function(board, hand) {
    const memo = new Map();

    function dfs(b, h) {
        const key = b + '#' + h.join('');
        if (memo.has(key)) return memo.get(key);

        if (b.length === 0) return 0;

        let res = Infinity;

        for (let i = 0; i < h.length; i++) {
            if (i > 0 && h[i] === h[i - 1]) continue;

            const newHand = [...h.slice(0, i), ...h.slice(i + 1)];

            for (let j = 0; j <= b.length; j++) {
                if (j > 0 && b[j - 1] === h[i]) continue;

                const newBoard = insertAndRemove(b.slice(0, j) + h[i] + insertAndRemove(b.slice(j));
                const temp = dfs(newBoard, newHand);
                if (temp !== Infinity) {
                    res = Math.min(res, temp + 1);
                }
            }
        }

        memo.set(key, res);
        return res;
    }

    function insertAndRemove(s) {
        let changed;
        do {
            changed = false;
            for (let i = 0; i < s.length; ) {
                let j = i;
                while (j < s.length && s[j] === s[i]) j++;
                if (j - i >= 3) {
                    s = s.slice(0, i) + s.slice(j);
                    changed = true;
                    break;
                }
                i = j;
            }
        } while (changed);
        return s;
    }

    const result = dfs(board, hand.split('').sort().join('').split(''));
    return result === Infinity ? -1 : result;
};