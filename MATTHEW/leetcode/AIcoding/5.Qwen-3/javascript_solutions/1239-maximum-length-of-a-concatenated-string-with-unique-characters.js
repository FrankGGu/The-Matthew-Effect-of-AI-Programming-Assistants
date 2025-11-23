function maxLength(arr) {
    const set = new Set();
    for (const s of arr) {
        const temp = new Set(s);
        if (temp.size === s.length) {
            set.add(s);
        }
    }
    const list = Array.from(set);
    let max = 0;
    function backtrack(start, current) {
        if (current.length > max) {
            max = current.length;
        }
        for (let i = start; i < list.length; i++) {
            const s = list[i];
            let valid = true;
            for (const c of s) {
                if (current.has(c)) {
                    valid = false;
                    break;
                }
            }
            if (valid) {
                for (const c of s) {
                    current.add(c);
                }
                backtrack(i + 1, current);
                for (const c of s) {
                    current.delete(c);
                }
            }
        }
    }
    backtrack(0, new Set());
    return max;
}