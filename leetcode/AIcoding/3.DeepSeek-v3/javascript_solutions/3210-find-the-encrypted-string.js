var findEncryptedWord = function(S) {
    if (S.length <= 1) return S;
    const mid = Math.floor((S.length - 1) / 2);
    const left = S.substring(0, mid);
    const right = S.substring(mid + 1);
    return S[mid] + findEncryptedWord(left) + findEncryptedWord(right);
};