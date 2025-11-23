var checkValidString = function(s) {
    let low = 0;
    let high = 0;

    for (let i = 0; i < s.length; i++) {
        const char = s[i];

        if (char === '(') {
            low++;
            high++;
        } else if (char === ')') {
            low = Math.max(0, low - 1);
            high--;
        } else { // char === '*'
            low = Math.max(0, low - 1);
            high++;
        }

        if (high < 0) {
            return false;
        }
    }

    return low === 0;
};