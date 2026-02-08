var maxUniqueSplit = function(s) {
    let max = 0;
    function backtrack(str, set) {
        if (str.length === 0) {
            max = Math.max(max, set.size);
            return;
        }

        for (let i = 1; i <= str.length; i++) {
            const sub = str.substring(0, i);
            if (!set.has(sub)) {
                set.add(sub);
                backtrack(str.substring(i), set);
                set.delete(sub);
            }
        }
    }

    backtrack(s, new Set());
    return max;
};