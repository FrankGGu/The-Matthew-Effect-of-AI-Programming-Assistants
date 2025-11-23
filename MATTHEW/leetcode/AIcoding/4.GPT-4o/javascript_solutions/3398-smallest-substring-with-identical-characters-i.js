var minimumLengthSubstring = function(s) {
    let minLength = Infinity;
    let n = s.length;

    for (let i = 0; i < n; i++) {
        let j = i;
        while (j < n && s[j] === s[i]) {
            j++;
        }
        minLength = Math.min(minLength, j - i);
        i = j - 1;
    }

    return minLength === Infinity ? 0 : minLength;
};