var substringXorQueries = function(s, queries) {
    const MAX_VAL = 1000000000;
    const MAX_SUBSTRING_LENGTH = 30;

    const uniqueValues = new Set();
    uniqueValues.add(0);

    for (let i = 0; i < s.length; i++) {
        let currentVal = 0;
        for (let j = i; j < Math.min(s.length, i + MAX_SUBSTRING_LENGTH); j++) {
            const bit = parseInt(s[j]);
            currentVal = currentVal * 2 + bit;

            if (currentVal > MAX_VAL) {
                break;
            }
            uniqueValues.add(currentVal);
        }
    }

    const sortedValues = Array.from(uniqueValues).sort((a, b) => a - b);

    const prefixXOR = new Array(sortedValues.length + 1).fill(0);
    for (let i = 0; i < sortedValues.length; i++) {
        prefixXOR[i + 1] = prefixXOR[i] ^ sortedValues[i];
    }

    const results = [];

    function lower_bound(arr, target) {
        let low = 0;
        let high = arr.length;
        while (low < high) {
            let mid = Math.floor(low + (high - low) / 2);
            if (arr[mid] < target) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        return low;
    }

    function upper_bound(arr, target) {
        let low = 0;
        let high = arr.length;
        while (low < high) {
            let mid = Math.floor(low + (high - low) / 2);
            if (arr[mid] <= target) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        return low;
    }

    for (const query of queries) {
        const [first, second] = query;

        const idxFirst = lower_bound(sortedValues, first);
        const idxSecond = upper_bound(sortedValues, second) - 1;

        if (idxFirst > idxSecond) {
            results.push(0);
        } else {
            results.push(prefixXOR[idxSecond + 1] ^ prefixXOR[idxFirst]);
        }
    }

    return results;
};