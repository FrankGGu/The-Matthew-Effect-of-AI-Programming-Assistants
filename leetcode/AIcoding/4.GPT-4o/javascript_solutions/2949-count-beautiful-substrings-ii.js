var countBeautifulSubstrings = function(s) {
    let count = 0;
    let n = s.length;

    for (let i = 0; i < n; i++) {
        let zeroCount = 0;
        let oneCount = 0;

        for (let j = i; j < n; j++) {
            if (s[j] === '0') {
                zeroCount++;
            } else {
                oneCount++;
            }

            if (zeroCount === oneCount) {
                count++;
            }
        }
    }

    return count;
};