var maxUniqueSplit = function(s) {
    let max = 0;
    const backtrack = (index, set) => {
        if (index === s.length) {
            max = Math.max(max, set.size);
            return;
        }
        for (let i = index + 1; i <= s.length; i++) {
            const substring = s.substring(index, i);
            if (!set.has(substring)) {
                set.add(substring);
                backtrack(i, set);
                set.delete(substring);
            }
        }
    };
    backtrack(0, new Set());
    return max;
};