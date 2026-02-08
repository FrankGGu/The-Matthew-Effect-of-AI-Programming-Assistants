var removeInvalidParentheses = function(s) {
    const result = new Set();
    let minRemoved = Infinity;

    const backtrack = (index, leftCount, rightCount, path, removed) => {
        if (index === s.length) {
            if (leftCount === rightCount) {
                if (removed < minRemoved) {
                    result.clear();
                    minRemoved = removed;
                    result.add(path);
                } else if (removed === minRemoved) {
                    result.add(path);
                }
            }
            return;
        }

        const char = s[index];
        if (char !== '(' && char !== ')') {
            backtrack(index + 1, leftCount, rightCount, path + char, removed);
            return;
        }

        backtrack(index + 1, leftCount, rightCount, path, removed + 1);

        if (char === '(') {
            backtrack(index + 1, leftCount + 1, rightCount, path + '(', removed);
        } else if (rightCount < leftCount) {
            backtrack(index + 1, leftCount, rightCount + 1, path + ')', removed);
        }
    };

    backtrack(0, 0, 0, '', 0);
    return Array.from(result);
};