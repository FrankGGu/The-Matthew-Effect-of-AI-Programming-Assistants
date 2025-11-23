function appealSum(s) {
    let total = 0;
    let last = new Map();

    for (let i = 0; i < s.length; i++) {
        let c = s[i];
        if (last.has(c)) {
            total += (i - last.get(c)) * (s.length - i);
        } else {
            total += (i + 1) * (s.length - i);
        }
        last.set(c, i);
    }

    return total;
}