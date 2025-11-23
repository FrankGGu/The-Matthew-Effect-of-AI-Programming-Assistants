var equalSubstring = function(s, t, maxCost) {
    let n = s.length;
    let left = 0;
    let cost = 0;
    let maxLength = 0;

    for (let right = 0; right < n; right++) {
        cost += Math.abs(s.charCodeAt(right) - t.charCodeAt(right));

        while (cost > maxCost) {
            cost -= Math.abs(s.charCodeAt(left) - t.charCodeAt(left));
            left++;
        }

        maxLength = Math.max(maxLength, right - left + 1);
    }

    return maxLength;
};