var kthDistinct = function(arr, k) {
    const counts = new Map();

    for (const str of arr) {
        counts.set(str, (counts.get(str) || 0) + 1);
    }

    for (const str of arr) {
        if (counts.get(str) === 1) {
            k--;
            if (k === 0) {
                return str;
            }
        }
    }

    return "";
};