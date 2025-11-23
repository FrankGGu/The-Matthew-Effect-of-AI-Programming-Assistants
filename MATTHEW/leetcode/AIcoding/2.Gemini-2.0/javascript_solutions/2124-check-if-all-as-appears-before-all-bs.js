var checkString = function(s) {
    let bFound = false;
    for (let i = 0; i < s.length; i++) {
        if (s[i] === 'b') {
            bFound = true;
        } else if (bFound && s[i] === 'a') {
            return false;
        }
    }
    return true;
};