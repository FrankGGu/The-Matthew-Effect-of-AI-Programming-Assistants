var makeStringsEqual = function(s, target) {
    let sHasOne = false;
    let targetHasOne = false;

    for (let i = 0; i < s.length; i++) {
        if (s[i] === '1') {
            sHasOne = true;
        }
        if (target[i] === '1') {
            targetHasOne = true;
        }
    }

    if (sHasOne === targetHasOne) {
        return true;
    } else {
        return false;
    }
};