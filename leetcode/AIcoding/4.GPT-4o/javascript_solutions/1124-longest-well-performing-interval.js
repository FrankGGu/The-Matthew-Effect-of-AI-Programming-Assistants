function longestWPI(hours) {
    let maxLength = 0;
    let sum = 0;
    const map = new Map();
    map.set(0, -1);

    for (let i = 0; i < hours.length; i++) {
        sum += hours[i] > 8 ? 1 : -1;

        if (sum > 0) {
            maxLength = i + 1;
        } else if (map.has(sum - 1)) {
            maxLength = Math.max(maxLength, i - map.get(sum - 1));
        }

        if (!map.has(sum)) {
            map.set(sum, i);
        }
    }

    return maxLength;
}