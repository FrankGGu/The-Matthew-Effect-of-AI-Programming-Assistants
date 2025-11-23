var takeCharacters = function(s, k) {
    let n = s.length;
    let countA = 0, countB = 0, countC = 0;
    for (let char of s) {
        if (char === 'a') countA++;
        else if (char === 'b') countB++;
        else countC++;
    }

    if (countA < k || countB < k || countC < k) return -1;

    let left = 0;
    let maxLen = 0;
    let a = 0, b = 0, c = 0;

    for (let right = 0; right < n; right++) {
        if (s[right] === 'a') a++;
        else if (s[right] === 'b') b++;
        else c++;

        while (a > countA - k || b > countB - k || c > countC - k) {
            if (s[left] === 'a') a--;
            else if (s[left] === 'b') b--;
            else c--;
            left++;
        }

        maxLen = Math.max(maxLen, right - left + 1);
    }

    return n - maxLen;
};