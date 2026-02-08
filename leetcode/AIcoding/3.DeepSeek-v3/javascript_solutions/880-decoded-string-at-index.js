var decodeAtIndex = function(S, K) {
    let size = 0;
    for (let char of S) {
        if (isNaN(char)) {
            size++;
        } else {
            size *= parseInt(char);
        }
    }

    for (let i = S.length - 1; i >= 0; i--) {
        K %= size;
        if (K === 0 && isNaN(S[i])) {
            return S[i];
        }

        if (!isNaN(S[i])) {
            size /= parseInt(S[i]);
        } else {
            size--;
        }
    }
    return "";
};