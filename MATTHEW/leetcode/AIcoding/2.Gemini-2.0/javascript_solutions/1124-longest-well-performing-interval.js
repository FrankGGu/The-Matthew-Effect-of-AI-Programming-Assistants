var longestWPI = function(hours) {
    let prefixSum = 0;
    let maxLength = 0;
    const map = new Map();
    map.set(0, -1);

    for (let i = 0; i < hours.length; i++) {
        prefixSum += hours[i] > 8 ? 1 : -1;

        if (prefixSum > 0) {
            maxLength = i + 1;
        } else {
            if (!map.has(prefixSum)) {
                map.set(prefixSum, i);
            }

            if (map.has(prefixSum - 1)) {
                maxLength = Math.max(maxLength, i - map.get(prefixSum - 1));
            }
        }
    }

    return maxLength;
};