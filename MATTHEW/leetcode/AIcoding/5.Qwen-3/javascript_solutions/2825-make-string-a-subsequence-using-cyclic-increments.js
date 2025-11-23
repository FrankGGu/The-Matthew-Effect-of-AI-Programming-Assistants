function canMakeSubsequence(source, target) {
    let i = 0, j = 0;
    while (i < source.length && j < target.length) {
        if (source[i] === target[j]) {
            i++;
            j++;
        } else {
            const sCode = source[i].charCodeAt(0);
            const tCode = target[j].charCodeAt(0);
            const nextChar = String.fromCharCode((sCode - 97 + 1) % 26 + 97);
            if (nextChar === target[j]) {
                i++;
                j++;
            } else {
                i++;
            }
        }
    }
    return j === target.length;
}