var isLongPressedName = function(s, t) {
    let i = 0;
    let j = 0;

    while (j < t.length) {
        if (i < s.length && s[i] === t[j]) {
            i++;
            j++;
        } else if (j > 0 && t[j] === t[j - 1]) {
            j++;
        } else {
            return false;
        }
    }

    return i === s.length;
};