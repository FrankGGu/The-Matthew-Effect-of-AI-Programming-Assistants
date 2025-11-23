var buddyStrings = function(s, goal) {
    if (s.length !== goal.length) {
        return false;
    }

    if (s === goal) {
        const charSet = new Set();
        for (let i = 0; i < s.length; i++) {
            if (charSet.has(s[i])) {
                return true;
            }
            charSet.add(s[i]);
        }
        return false;
    }

    const diffIndices = [];
    for (let i = 0; i < s.length; i++) {
        if (s[i] !== goal[i]) {
            diffIndices.push(i);
        }
    }

    if (diffIndices.length === 2) {
        const i1 = diffIndices[0];
        const i2 = diffIndices[1];
        return s[i1] === goal[i2] && s[i2] === goal[i1];
    }

    return false;
};