var equalSubstring = function(s, t, maxCost) {
    let left = 0;
    let currentCost = 0;
    let maxLength = 0;

    for (let right = 0; right < s.length; right++) {
        currentCost += Math.abs(s.charCodeAt(right) - t.charCodeAt(right));

        while (currentCost > maxCost) {
            currentCost -= Math.abs(s.charCodeAt(left) - t.charCodeAt(left));
            left++;
        }

        maxLength = Math.max(maxLength, right - left + 1);
    }

    return maxLength;
};