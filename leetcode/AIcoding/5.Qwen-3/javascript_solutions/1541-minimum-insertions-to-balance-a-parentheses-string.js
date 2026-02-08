function minInsertions(s) {
    let res = 0;
    let left = 0;
    for (let i = 0; i < s.length; i++) {
        if (s[i] === '(') {
            left++;
        } else {
            left--;
            if (left < 0) {
                res++;
                left += 2;
            }
        }
    }
    return res + left;
}