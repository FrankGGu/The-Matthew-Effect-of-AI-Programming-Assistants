var minInsertions = function(s) {
    let ans = 0;
    let need = 0;
    for (let i = 0; i < s.length; i++) {
        if (s[i] === '(') {
            if (need % 2 !== 0) {
                ans++;
                need--;
            }
            need += 2;
        } else {
            need--;
            if (need < 0) {
                ans++;
                need = 1;
            }
        }
    }
    return ans + need;
};