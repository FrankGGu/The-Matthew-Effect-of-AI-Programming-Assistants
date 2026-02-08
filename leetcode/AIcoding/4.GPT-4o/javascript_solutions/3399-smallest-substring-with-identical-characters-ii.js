function smallestSubstring(s) {
    let n = s.length;
    let left = 0;
    let minLength = Infinity;
    let minSubstring = "";
    let count = new Map();

    for (let right = 0; right < n; right++) {
        count.set(s[right], (count.get(s[right]) || 0) + 1);

        while (count.size > 2) {
            count.set(s[left], count.get(s[left]) - 1);
            if (count.get(s[left]) === 0) {
                count.delete(s[left]);
            }
            left++;
        }

        if (count.size === 2) {
            let currentLength = right - left + 1;
            if (currentLength < minLength) {
                minLength = currentLength;
                minSubstring = s.substring(left, right + 1);
            }
        }
    }

    return minSubstring;
}