var decodeAtIndex = function(s, k) {
    let size = 0;
    for (let i = 0; i < s.length; i++) {
        if (isNaN(parseInt(s[i]))) {
            size++;
        } else {
            size *= parseInt(s[i]);
        }
    }

    for (let i = s.length - 1; i >= 0; i--) {
        k %= size;
        if (k === 0 && isNaN(parseInt(s[i]))) {
            return s[i];
        }

        if (isNaN(parseInt(s[i]))) {
            size--;
        } else {
            size /= parseInt(s[i]);
        }
    }

    return "";
};