function areAlmostEqual(s, t) {
    if (s.length !== t.length) return false;
    let diff = [];
    for (let i = 0; i < s.length; i++) {
        if (s[i] !== t[i]) {
            diff.push(i);
            if (diff.length > 2) return false;
        }
    }
    return diff.length === 0 || (diff.length === 2 && s[diff[0]] === t[diff[1]] && s[diff[1]] === t[diff[0]]);
}