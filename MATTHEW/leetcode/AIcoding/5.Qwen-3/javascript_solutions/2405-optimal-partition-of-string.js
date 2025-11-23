function partitionString(s) {
    let count = 1;
    let set = new Set();
    for (let c of s) {
        if (set.has(c)) {
            count++;
            set = new Set([c]);
        } else {
            set.add(c);
        }
    }
    return count;
}