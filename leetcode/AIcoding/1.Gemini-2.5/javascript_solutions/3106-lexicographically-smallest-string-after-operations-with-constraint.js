var getSmallestString = function(s, k, c) {
    let sArr = s.split('');
    const aCharCode = 'a'.charCodeAt(0);
    const cCharCode = c.charCodeAt(0);

    for (let i = 0; i < sArr.length; i++) {
        if (k === 0) {
            break;
        }

        const currentCharCode = sArr[i].charCodeAt(0);

        if (currentCharCode <= cCharCode) {
            continue;
        }

        const stepsToA = currentCharCode - aCharCode;

        if (k >= stepsToA) {
            sArr[i] = 'a';
            k -= stepsToA;
        } else {
            const newCharCode = currentCharCode - k;
            sArr[i] = String.fromCharCode(newCharCode);
            k = 0;
            break;
        }
    }

    return sArr.join('');
};