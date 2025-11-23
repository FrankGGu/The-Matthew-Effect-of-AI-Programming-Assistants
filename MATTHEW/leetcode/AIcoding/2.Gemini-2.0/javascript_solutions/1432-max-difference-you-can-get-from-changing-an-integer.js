var maxDiff = function(num) {
    const s = String(num);
    const n = s.length;

    let maxNum = 0;
    let minNum = 0;

    // Find maxNum
    let maxS = s.split('');
    let replaceDigit = null;
    for (let i = 0; i < n; i++) {
        if (s[i] !== '9') {
            replaceDigit = s[i];
            break;
        }
    }
    if (replaceDigit !== null) {
        for (let i = 0; i < n; i++) {
            if (maxS[i] === replaceDigit) {
                maxS[i] = '9';
            }
        }
        maxNum = parseInt(maxS.join(''));
    } else {
        maxNum = num;
    }

    // Find minNum
    let minS = s.split('');
    replaceDigit = null;
    if (s[0] !== '1') {
        replaceDigit = s[0];
        for (let i = 0; i < n; i++) {
            if (minS[i] === replaceDigit) {
                minS[i] = '1';
            }
        }
        minNum = parseInt(minS.join(''));
    } else {
        for (let i = 1; i < n; i++) {
            if (s[i] !== '0' && s[i] !== '1') {
                replaceDigit = s[i];
                break;
            }
        }
        if (replaceDigit !== null) {
            for (let i = 0; i < n; i++) {
                if (minS[i] === replaceDigit) {
                    minS[i] = '0';
                }
            }
            minNum = parseInt(minS.join(''));
        } else {
            minNum = num;
        }
    }

    return maxNum - minNum;
};