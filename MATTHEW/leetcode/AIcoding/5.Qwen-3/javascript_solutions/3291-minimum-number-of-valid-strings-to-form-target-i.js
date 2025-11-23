function minValidStrings(allowed, target) {
    const set = new Set(allowed);
    let count = 0;
    let i = 0;
    while (i < target.length) {
        let found = false;
        for (let j = 1; j <= target.length - i; j++) {
            if (set.has(target.substring(i, i + j))) {
                i += j;
                found = true;
                break;
            }
        }
        if (!found) return -1;
        count++;
    }
    return count;
}