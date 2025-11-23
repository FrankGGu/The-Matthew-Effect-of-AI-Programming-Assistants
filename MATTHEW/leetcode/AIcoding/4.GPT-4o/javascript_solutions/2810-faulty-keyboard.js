function faultyKeyboard(s, t) {
    const sCount = Array(26).fill(0);
    const tCount = Array(26).fill(0);

    for (const char of s) {
        sCount[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    for (const char of t) {
        tCount[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    for (let i = 0; i < 26; i++) {
        if (sCount[i] < tCount[i]) {
            return false;
        }
    }

    return true;
}