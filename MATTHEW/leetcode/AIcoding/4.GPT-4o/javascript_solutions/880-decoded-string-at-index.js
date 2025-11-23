var decodeAtIndex = function(S, K) {
    let length = 0;
    for (let i = 0; i < S.length; i++) {
        if (isNaN(S[i])) {
            length++;
        } else {
            length *= Number(S[i]);
        }
        if (length >= K) {
            break;
        }
    }

    for (let j = i; j >= 0; j--) {
        K %= length;
        if (K === 0 && !isNaN(S[j])) return S[j - 1];
        if (K === 0) return S[j];
        if (!isNaN(S[j])) {
            length /= Number(S[j]);
        } else {
            length--;
        }
    }
    return "";
};