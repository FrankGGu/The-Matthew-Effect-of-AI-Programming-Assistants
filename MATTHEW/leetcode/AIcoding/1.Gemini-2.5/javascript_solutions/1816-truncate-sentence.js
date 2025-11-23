var truncateSentence = function(s, k) {
    let count = 0;
    let endIndex = -1;

    for (let i = 0; i < s.length; i++) {
        if (s[i] === ' ') {
            count++;
            if (count === k) {
                endIndex = i;
                break;
            }
        }
    }

    if (endIndex === -1) {
        return s;
    } else {
        return s.substring(0, endIndex);
    }
};