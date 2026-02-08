var uniqueLetterString = function(s) {
    let n = s.length;
    let left = new Array(n).fill(0);
    let right = new Array(n).fill(0);
    let lastPos = new Map();

    for (let i = 0; i < n; i++) {
        let char = s[i];
        if (lastPos.has(char)) {
            left[i] = i - lastPos.get(char);
        } else {
            left[i] = i + 1;
        }
        lastPos.set(char, i);
    }

    lastPos.clear();

    for (let i = n - 1; i >= 0; i--) {
        let char = s[i];
        if (lastPos.has(char)) {
            right[i] = lastPos.get(char) - i;
        } else {
            right[i] = n - i;
        }
        lastPos.set(char, i);
    }

    let ans = 0;
    for (let i = 0; i < n; i++) {
        ans = (ans + left[i] * right[i]) % (10**9 + 7);
    }

    return ans;
};