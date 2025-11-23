var findSpecialSubstring = function(s, k) {
    let count = 0;
    for (let i = 0; i <= s.length - k; i++) {
        let sub = s.substring(i, i + k);
        let isSpecial = true;
        for (let j = 0; j < k; j++) {
            if (sub[j] === sub[0]) {
                if (j > 0 && sub[j] !== sub[j - 1]) {
                    isSpecial = false;
                    break;
                }
            } else {
                isSpecial = false;
                break;
            }
        }
        if (isSpecial) {
            count++;
        }
    }
    return count;
};