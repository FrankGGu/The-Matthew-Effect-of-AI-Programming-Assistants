var findTheEncryptedString = function(s, k) {
    let n = s.length;
    let arr = s.split('').map(char => char.charCodeAt(0) - 'a'.charCodeAt(0));

    for (let i = n - 1; i >= 0; i--) {
        arr[i] = (arr[i] - k + 26) % 26;
        k = (k * 2) % 26;
    }

    return arr.map(num => String.fromCharCode(num + 'a'.charCodeAt(0))).join('');
};