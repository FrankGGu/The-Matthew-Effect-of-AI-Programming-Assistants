function getEncryptedString(s, k) {
    let n = s.length;
    k = k % n;
    let result = '';
    for (let i = 0; i < n; i++) {
        result += s[(i + k) % n];
    }
    return result;
}