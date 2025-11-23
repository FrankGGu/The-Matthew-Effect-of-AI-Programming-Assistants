var findFirstAlmostEqualSubstring = function(s, t, maxCost) {
    let left = 0;
    let currentCost = 0;
    let maxLength = 0;
    let result = '';

    for (let right = 0; right < s.length; right++) {
        currentCost += Math.abs(s.charCodeAt(right) - t.charCodeAt(right));

        while (currentCost > maxCost) {
            currentCost -= Math.abs(s.charCodeAt(left) - t.charCodeAt(left));
            left++;
        }

        if (right - left + 1 > maxLength) {
            maxLength = right - left + 1;
            result = s.substring(left, right + 1);
        }
    }

    return result;
};