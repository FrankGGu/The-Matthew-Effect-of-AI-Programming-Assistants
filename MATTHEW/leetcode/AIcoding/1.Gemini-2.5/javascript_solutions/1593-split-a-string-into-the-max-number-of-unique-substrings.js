var maxUniqueSplits = function(s) {
    let maxCount = 0;
    const n = s.length;

    function backtrack(start_index, current_set) {
        if (start_index === n) {
            maxCount = Math.max(maxCount, current_set.size);
            return;
        }

        for (let end_index = start_index; end_index < n; end_index++) {
            const sub = s.substring(start_index, end_index + 1);

            if (!current_set.has(sub)) {
                current_set.add(sub);
                backtrack(end_index + 1, current_set);
                current_set.delete(sub);
            }
        }
    }

    backtrack(0, new Set());
    return maxCount;
};