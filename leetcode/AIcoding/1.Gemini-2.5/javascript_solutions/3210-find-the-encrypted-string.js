var getEncryptedString = function(s, k) {
    const n = s.length;
    let encryptedString = '';
    for (let i = 0; i < n; i++) {
        encryptedString += s[(i + k) % n];
    }
    return encryptedString;
};