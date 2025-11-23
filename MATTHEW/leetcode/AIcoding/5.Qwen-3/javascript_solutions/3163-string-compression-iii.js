function compressString(s) {
    let result = '';
    let i = 0;
    while (i < s.length) {
        let char = s[i];
        let count = 0;
        while (i < s.length && s[i] === char) {
            count++;
            i++;
        }
        result += char + count;
    }
    return result;
}