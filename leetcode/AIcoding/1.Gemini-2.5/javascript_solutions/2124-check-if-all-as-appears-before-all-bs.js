var checkString = function(s) {
    let foundB = false;
    for (let i = 0; i < s.length; i++) {
        if (s[i] === 'a') {
            if (foundB) {
                return false;
            }
        } else { // s[i] === 'b'
            foundB = true;
        }
    }
    return true;
};