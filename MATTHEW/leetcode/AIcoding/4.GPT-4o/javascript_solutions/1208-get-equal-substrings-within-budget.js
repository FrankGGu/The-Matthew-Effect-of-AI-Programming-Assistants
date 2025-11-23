var equalSubstring = function(s, t, maxCost) {
    let left = 0, right = 0, totalCost = 0, maxLength = 0;

    while (right < s.length) {
        totalCost += Math.abs(s.charCodeAt(right) - t.charCodeAt(right));

        while (totalCost > maxCost) {
            totalCost -= Math.abs(s.charCodeAt(left) - t.charCodeAt(left));
            left++;
        }

        maxLength = Math.max(maxLength, right - left + 1);
        right++;
    }

    return maxLength;
};