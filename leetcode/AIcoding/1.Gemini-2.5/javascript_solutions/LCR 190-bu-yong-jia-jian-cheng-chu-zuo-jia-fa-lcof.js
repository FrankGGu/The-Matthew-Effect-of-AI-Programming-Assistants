var encrypt = function(s, k) {
    let result = [];
    k = k % 26;
    if (k < 0) k += 26;

    for (let i = 0; i < s.length; i++) {
        let char = s[i];
        if (char >= 'a' && char <= 'z') {
            let charCode = char.charCodeAt(0);
            let shiftedCode = ((charCode - 'a'.charCodeAt(0) + k) % 26) + 'a'.charCodeAt(0);
            result.push(String.fromCharCode(shiftedCode));
        } else if (char >= 'A' && char <= 'Z') {
            let charCode = char.charCodeAt(0);
            let shiftedCode = ((charCode - 'A'.charCodeAt(0) + k) % 26) + 'A'.charCodeAt(0);
            result.push(String.fromCharCode(shiftedCode));
        } else {
            result.push(char);
        }
    }
    return result.join('');
};