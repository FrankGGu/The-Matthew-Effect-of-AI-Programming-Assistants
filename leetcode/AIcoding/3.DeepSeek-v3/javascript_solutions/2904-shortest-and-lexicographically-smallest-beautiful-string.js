var shortestBeautifulSubstring = function(s, k) {
    let left = 0;
    let count = 0;
    let minLen = Infinity;
    let result = "";

    for (let right = 0; right < s.length; right++) {
        if (s[right] === '1') {
            count++;
        }

        while (count === k) {
            const currentLen = right - left + 1;
            const currentStr = s.substring(left, right + 1);

            if (currentLen < minLen) {
                minLen = currentLen;
                result = currentStr;
            } else if (currentLen === minLen && currentStr < result) {
                result = currentStr;
            }

            if (s[left] === '1') {
                count--;
            }
            left++;
        }
    }

    return result;
};