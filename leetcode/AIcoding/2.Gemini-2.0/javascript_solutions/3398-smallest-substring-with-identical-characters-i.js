var smallestSubstring = function(s) {
    let n = s.length;
    let minLen = Infinity;

    for (let i = 0; i < n; i++) {
        for (let j = i; j < n; j++) {
            let sub = s.substring(i, j + 1);
            if (sub.length > 0) {
                let allSame = true;
                for (let k = 1; k < sub.length; k++) {
                    if (sub[k] !== sub[0]) {
                        allSame = false;
                        break;
                    }
                }
                if (allSame) {
                    minLen = Math.min(minLen, sub.length);
                }
            }
        }
    }

    return minLen === Infinity ? -1 : minLen;
};