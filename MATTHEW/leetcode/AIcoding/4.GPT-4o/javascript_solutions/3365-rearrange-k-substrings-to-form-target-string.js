function canRearrange(K, S, T) {
    if (S.length !== T.length) return false;

    const countS = Array(26).fill(0);
    const countT = Array(26).fill(0);

    for (let char of S) {
        countS[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    for (let char of T) {
        countT[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    for (let i = 0; i < 26; i++) {
        if (countS[i] < countT[i]) return false;
        if ((countS[i] - countT[i]) % K !== 0) return false;
    }

    return true;
}