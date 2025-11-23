var getDescriptiveString = function(s, k) {
    const n = s.length;
    const arr = s.split('');
    const charA = 'a'.charCodeAt(0);
    const maxAllowedCharCode = charA + k;

    function isBeautiful(currentArr, len) {
        for (let i = 0; i < len; i++) {
            const charCode = currentArr[i].charCodeAt(0);
            if (charCode < charA || charCode >= maxAllowedCharCode) {
                return false;
            }
            if (i > 0 && currentArr[i] === currentArr[i-1]) {
                return false;
            }
            if (i > 1 && currentArr[i] === currentArr[i-2]) {
                return false;
            }
        }
        return true;
    }

    if (isBeautiful(arr, n)) {
        return s;
    }

    for (let i = n - 1; i >= 0; i--) {
        for (let charCode = arr[i].charCodeAt(0) + 1; charCode < maxAllowedCharCode; charCode++) {
            const nextChar = String.fromCharCode(charCode);

            let validFor_i = true;
            if (i > 0 && arr[i-1] === nextChar) {
                validFor_i = false;
            }
            if (i > 1 && arr[i-2] === nextChar) {
                validFor_i = false;
            }

            if (validFor_i) {
                arr[i] = nextChar;

                for (let j = i + 1; j < n; j++) {
                    for (let fillCharCode = charA; fillCharCode < maxAllowedCharCode; fillCharCode++) {
                        const fillChar = String.fromCharCode(fillCharCode);

                        let validFor_j = true;
                        if (j > 0 && arr[j-1] === fillChar) {
                            validFor_j = false;
                        }
                        if (j > 1 && arr[j-2] === fillChar) {
                            validFor_j = false;
                        }

                        if (validFor_j) {
                            arr[j] = fillChar;
                            break;
                        }
                    }
                }
                return arr.join('');
            }
        }
    }

    return "";
};