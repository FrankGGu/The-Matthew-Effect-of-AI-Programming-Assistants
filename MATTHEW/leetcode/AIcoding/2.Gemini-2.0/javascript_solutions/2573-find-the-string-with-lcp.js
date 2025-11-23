var findTheString = function(lcp) {
    const n = lcp.length;
    let s = "";
    let charMap = new Map();
    let nextChar = 'a';

    for (let i = 0; i < n; i++) {
        if (s.length <= i) {
            s += nextChar;
            charMap.set(i, nextChar);
            nextChar = String.fromCharCode(nextChar.charCodeAt(0) + 1);
        }
        for (let j = 0; j < n; j++) {
            if (lcp[i][j] > 0 && s.length <= j) {
                if (charMap.has(i)) {
                    s += charMap.get(i);
                    charMap.set(j, charMap.get(i));
                } else {
                   return "";
                }
            }
        }
    }

    let constructedLCP = Array(n).fill(null).map(() => Array(n).fill(0));
    for (let i = n - 1; i >= 0; i--) {
        for (let j = n - 1; j >= 0; j--) {
            if (s[i] === s[j]) {
                if (i === n - 1 || j === n - 1) {
                    constructedLCP[i][j] = 1;
                } else {
                    constructedLCP[i][j] = constructedLCP[i + 1][j + 1] + 1;
                }
            } else {
                constructedLCP[i][j] = 0;
            }
        }
    }

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (lcp[i][j] !== constructedLCP[i][j]) {
                return "";
            }
        }
    }

    return s;
};