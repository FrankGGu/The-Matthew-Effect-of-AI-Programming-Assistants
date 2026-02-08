var splitString = function(s) {
    function backtrack(index, prev) {
        if (index === s.length) {
            return true;
        }

        for (let i = index; i < s.length; i++) {
            const current = parseInt(s.substring(index, i + 1));
            if (isNaN(current)) continue;

            if (prev === null || prev - current === 1) {
                if (backtrack(i + 1, current)) {
                    return true;
                }
            }
        }

        return false;
    }

    for (let i = 0; i < s.length - 1; i++) {
        const first = parseInt(s.substring(0, i + 1));
        if (isNaN(first)) continue;
        if (backtrack(i + 1, first)) {
            return true;
        }
    }

    return false;
};