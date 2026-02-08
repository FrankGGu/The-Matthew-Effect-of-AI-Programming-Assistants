var minWindow = function(s, t) {
    if (t.length === 0) {
        return "";
    }

    let charCount = {};
    for (let char of t) {
        charCount[char] = (charCount[char] || 0) + 1;
    }

    let windowStart = 0;
    let matched = 0;
    let minLength = Infinity;
    let substringStart = 0;

    for (let windowEnd = 0; windowEnd < s.length; windowEnd++) {
        let rightChar = s[windowEnd];

        if (rightChar in charCount) {
            charCount[rightChar]--;
            if (charCount[rightChar] >= 0) { 
                matched++;
            }
        }

        while (matched === t.length) {
            if (windowEnd - windowStart + 1 < minLength) {
                minLength = windowEnd - windowStart + 1;
                substringStart = windowStart;
            }

            let leftChar = s[windowStart];
            windowStart++;

            if (leftChar in charCount) {
                if (charCount[leftChar] === 0) { 
                    matched--;
                }
                charCount[leftChar]++;
            }
        }
    }

    if (minLength === Infinity) {
        return "";
    }

    return s.substring(substringStart, substringStart + minLength);
};