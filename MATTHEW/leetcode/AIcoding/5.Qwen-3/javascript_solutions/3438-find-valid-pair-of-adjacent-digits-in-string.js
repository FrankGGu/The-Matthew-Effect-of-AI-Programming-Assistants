function validPair(s) {
    for (let i = 0; i < s.length - 1; i++) {
        if (Math.abs(parseInt(s[i]) - parseInt(s[i + 1])) === 1) {
            return true;
        }
    }
    return false;
}