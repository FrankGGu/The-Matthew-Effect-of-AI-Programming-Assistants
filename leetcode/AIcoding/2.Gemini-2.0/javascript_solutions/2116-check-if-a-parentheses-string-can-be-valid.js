var canBeValid = function(s, locked) {
    if (s.length % 2 !== 0) {
        return false;
    }

    let open = 0;
    let close = 0;
    let unlocked = 0;

    for (let i = 0; i < s.length; i++) {
        if (locked[i] === '1') {
            if (s[i] === '(') {
                open++;
            } else {
                close++;
            }
        } else {
            unlocked++;
        }

        if (close > open + unlocked) {
            return false;
        }
    }

    open = 0;
    close = 0;
    unlocked = 0;

    for (let i = s.length - 1; i >= 0; i--) {
        if (locked[i] === '1') {
            if (s[i] === ')') {
                close++;
            } else {
                open++;
            }
        } else {
            unlocked++;
        }

        if (open > close + unlocked) {
            return false;
        }
    }

    return true;
};