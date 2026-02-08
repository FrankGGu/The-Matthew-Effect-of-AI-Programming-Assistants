var shortestBeautifulSubstring = function(s, k) {
    let n = s.length;
    let minLen = Infinity;
    let res = "";
    for (let i = 0; i < n; i++) {
        let count = 0;
        for (let j = i; j < n; j++) {
            if (s[j] === '1') {
                count++;
            }
            if (count === k) {
                let len = j - i + 1;
                let sub = s.substring(i, j + 1);
                if (len < minLen) {
                    minLen = len;
                    res = sub;
                } else if (len === minLen && (res === "" || sub < res)) {
                    res = sub;
                }
                break;
            }
        }
    }
    return res;
};