var numDecodings = function(s) {
    if (s === null || s.length === 0) {
        return 0;
    }

    const n = s.length;

    let dp_prev2 = 1; 
    let dp_prev1 = s[0] === '0' ? 0 : 1; 

    if (s[0] === '0') {
        return 0;
    }

    for (let i = 2; i <= n; i++) {
        let dp_curr = 0;

        let oneDigit = parseInt(s.substring(i - 1, i));
        if (oneDigit >= 1 && oneDigit <= 9) {
            dp_curr += dp_prev1;
        }

        let twoDigits = parseInt(s.substring(i - 2, i));
        if (twoDigits >= 10 && twoDigits <= 26) {
            dp_curr += dp_prev2;
        }

        dp_prev2 = dp_prev1;
        dp_prev1 = dp_curr;
    }

    return dp_prev1;
};