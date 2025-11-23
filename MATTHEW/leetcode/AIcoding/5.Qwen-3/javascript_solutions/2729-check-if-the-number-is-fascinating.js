function isFascinating(num) {
    const s = num.toString();
    if (s.length < 3) return false;
    const set = new Set(s);
    if (set.size !== 3) return false;
    for (let i = 1; i <= 9; i++) {
        if (!s.includes(i.toString())) return false;
    }
    return true;
}