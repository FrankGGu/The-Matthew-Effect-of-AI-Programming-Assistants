var balancedStringSplit = function(s) {
    let balancedStrings = 0;
    let balance = 0;

    for (let i = 0; i < s.length; i++) {
        if (s[i] === 'L') {
            balance++;
        } else {
            balance--;
        }

        if (balance === 0) {
            balancedStrings++;
        }
    }

    return balancedStrings;
};