function checkIfBinaryStringHasAtMostOneSegmentOfOnes(s) {
    let foundOne = false;
    for (let i = 0; i < s.length; i++) {
        if (s[i] === '1') {
            if (foundOne) {
                return false;
            }
            foundOne = true;
        }
    }
    return true;
}