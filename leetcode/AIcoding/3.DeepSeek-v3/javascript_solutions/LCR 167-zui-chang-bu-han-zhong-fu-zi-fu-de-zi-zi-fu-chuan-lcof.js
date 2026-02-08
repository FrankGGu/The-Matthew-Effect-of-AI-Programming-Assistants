var dismantlingAction = function(arr) {
    let map = new Map();
    let left = 0;
    let maxLen = 0;

    for (let right = 0; right < arr.length; right++) {
        if (map.has(arr[right])) {
            left = Math.max(left, map.get(arr[right]) + 1);
        }
        map.set(arr[right], right);
        maxLen = Math.max(maxLen, right - left + 1);
    }

    return maxLen;
};