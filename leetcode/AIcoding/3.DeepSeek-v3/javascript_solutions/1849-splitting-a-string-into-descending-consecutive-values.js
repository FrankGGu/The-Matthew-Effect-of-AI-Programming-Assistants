var splitString = function(s) {
    const n = s.length;

    const backtrack = (index, prev) => {
        if (index === n) {
            return true;
        }

        for (let i = index; i < n; i++) {
            const num = parseInt(s.substring(index, i + 1));
            if (prev === null) {
                if (backtrack(i + 1, num)) {
                    return true;
                }
            } else if (num === prev - 1) {
                if (backtrack(i + 1, num)) {
                    return true;
                }
            }
        }
        return false;
    };

    return backtrack(0, null);
};