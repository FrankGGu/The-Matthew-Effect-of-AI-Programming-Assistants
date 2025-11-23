function constructLargeNum(n) {
    const result = [];

    function backtrack(current, used) {
        if (current.length === n) {
            return [...current];
        }

        for (let i = n; i >= 1; i--) {
            if (!used[i]) {
                if (current.length === 0 || (i + current[current.length - 1]) % 2 === 1) {
                    used[i] = true;
                    current.push(i);
                    const res = backtrack(current, used);
                    if (res) return res;
                    current.pop();
                    used[i] = false;
                }
            }
        }

        return null;
    }

    return backtrack([], Array(n + 1).fill(false));
}