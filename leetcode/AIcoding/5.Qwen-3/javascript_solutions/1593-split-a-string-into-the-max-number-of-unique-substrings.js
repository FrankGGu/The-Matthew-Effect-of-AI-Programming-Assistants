function maxUniqueSplit(s) {
    const n = s.length;
    let result = 0;

    function backtrack(start, seen) {
        if (start === n) {
            result = Math.max(result, seen.size);
            return;
        }

        for (let end = start + 1; end <= n; end++) {
            const substr = s.substring(start, end);
            if (!seen.has(substr)) {
                seen.add(substr);
                backtrack(end, seen);
                seen.delete(substr);
            }
        }
    }

    backtrack(0, new Set());
    return result;
}