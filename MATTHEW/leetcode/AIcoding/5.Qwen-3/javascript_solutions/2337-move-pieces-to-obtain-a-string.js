function canBeEqual(target) {
    let s = "OOXX";
    let t = target;
    let i = 0;
    let j = 0;
    while (i < s.length && j < t.length) {
        if (s[i] === t[j]) {
            i++;
            j++;
        } else {
            if (s[i] === 'O' && t[j] === 'O') {
                j++;
            } else if (s[i] === 'X' && t[j] === 'X') {
                i++;
            } else {
                return false;
            }
        }
    }
    return i === s.length && j === t.length;
}