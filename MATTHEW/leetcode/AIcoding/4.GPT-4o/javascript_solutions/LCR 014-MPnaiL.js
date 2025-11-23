var permutation = function(s) {
    const res = [];
    const used = Array(s.length).fill(false);
    const path = [];

    const backtrack = () => {
        if (path.length === s.length) {
            res.push(path.join(''));
            return;
        }

        const seen = new Set();
        for (let i = 0; i < s.length; i++) {
            if (used[i] || seen.has(s[i])) continue;
            seen.add(s[i]);
            used[i] = true;
            path.push(s[i]);
            backtrack();
            path.pop();
            used[i] = false;
        }
    };

    backtrack();
    return res;
};