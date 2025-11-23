var smallestBeautifulString = function(s, k) {
    const n = s.length;
    const arr = s.split('');

    for (let i = n - 1; i >= 0; i--) {
        let charCode = arr[i].charCodeAt(0) + 1;
        while (charCode < 'a'.charCodeAt(0) + k) {
            const char = String.fromCharCode(charCode);
            if ((i > 0 && char === arr[i - 1]) || (i > 1 && char === arr[i - 2])) {
                charCode++;
            } else {
                arr[i] = char;
                for (let j = i + 1; j < n; j++) {
                    let newCharCode = 'a'.charCodeAt(0);
                    while (newCharCode < 'a'.charCodeAt(0) + k) {
                        const newChar = String.fromCharCode(newCharCode);
                        if ((j > 0 && newChar === arr[j - 1]) || (j > 1 && newChar === arr[j - 2])) {
                            newCharCode++;
                        } else {
                            arr[j] = newChar;
                            break;
                        }
                    }
                    if (newCharCode === 'a'.charCodeAt(0) + k) {
                        return "";
                    }
                }
                return arr.join('');
            }
        }
    }

    return "";
};