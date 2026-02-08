var getSmallestString = function(s, k) {
    const n = s.length;
    let res = s.split('');
    let remaining = k;

    for (let i = 0; i < n && remaining > 0; i++) {
        const currentChar = res[i];
        const targetChar = 'a';
        const distance = Math.min(
            currentChar.charCodeAt(0) - targetChar.charCodeAt(0),
            26 - (currentChar.charCodeAt(0) - targetChar.charCodeAt(0))
        );
        const change = Math.min(distance, remaining);

        if (change > 0) {
            let newCharCode;
            if (currentChar.charCodeAt(0) - change >= 'a'.charCodeAt(0)) {
                newCharCode = currentChar.charCodeAt(0) - change;
            } else {
                newCharCode = 'a'.charCodeAt(0) + (change - (currentChar.charCodeAt(0) - 'a'.charCodeAt(0)));
            }
            res[i] = String.fromCharCode(newCharCode);
            remaining -= change;
        }
    }

    return res.join('');
};