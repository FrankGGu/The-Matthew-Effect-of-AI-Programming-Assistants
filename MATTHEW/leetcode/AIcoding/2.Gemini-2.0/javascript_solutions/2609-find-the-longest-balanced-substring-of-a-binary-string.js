var findTheLongestBalancedSubstring = function(s) {
    let maxLen = 0;
    for (let i = 0; i < s.length; i++) {
        for (let j = i + 1; j <= s.length; j++) {
            const sub = s.substring(i, j);
            let zeros = 0;
            let ones = 0;
            for (let k = 0; k < sub.length; k++) {
                if (sub[k] === '0') {
                    zeros++;
                } else {
                    ones++;
                }
            }
            if (zeros === ones && sub.length > 0) {
                let valid = true;
                let zeroCount = 0;
                for (let k = 0; k < zeros; k++) {
                    if (sub[k] === '0') {
                        zeroCount++;
                    } else {
                        valid = false;
                        break;
                    }
                }
                if (valid) {
                    let oneCount = 0;
                    for (let k = zeros; k < sub.length; k++) {
                        if (sub[k] === '1') {
                            oneCount++;
                        } else {
                            valid = false;
                            break;
                        }
                    }
                    if (valid) {
                        maxLen = Math.max(maxLen, sub.length);
                    }
                }
            }
        }
    }
    return maxLen;
};