function canMakeSubsequence(s, t) {
    let j = 0;
    for (let i = 0; i < s.length; i++) {
        if (j < t.length && (s[i] === t[j] || (s[i] === 'z' && t[j] === 'a'))) {
            j++;
        } else if (j < t.length && s[i] === String.fromCharCode((t[j].charCodeAt(0) - 'a'.charCodeAt(0) - 1 + 26) % 26 + 'a'.charCodeAt(0))) {
            j++;
        }
    }
    return j === t.length;
}