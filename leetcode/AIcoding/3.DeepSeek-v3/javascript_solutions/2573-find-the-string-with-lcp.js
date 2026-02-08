var findTheString = function(lcp) {
    const n = lcp.length;
    let res = new Array(n).fill('');
    let c = 'a';

    for (let i = 0; i < n; i++) {
        if (res[i] === '') {
            if (c > 'z') return "";
            res[i] = c;
            for (let j = i + 1; j < n; j++) {
                if (lcp[i][j] > 0) {
                    res[j] = res[i];
                }
            }
            c = String.fromCharCode(c.charCodeAt(0) + 1);
        }
    }

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            let val = 0;
            if (i < n - 1 && j < n - 1 && res[i] === res[j]) {
                val = lcp[i + 1][j + 1] + 1;
            }
            val = Math.min(val, n - i, n - j);
            if (i === n - 1 || j === n - 1) {
                val = res[i] === res[j] ? 1 : 0;
            }
            if (lcp[i][j] !== val) {
                return "";
            }
        }
    }

    return res.join('');
};