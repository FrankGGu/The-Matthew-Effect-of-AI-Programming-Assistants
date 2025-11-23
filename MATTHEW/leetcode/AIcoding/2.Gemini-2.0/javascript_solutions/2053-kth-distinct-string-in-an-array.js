var kthDistinct = function(arr, k) {
    const counts = {};
    for (const str of arr) {
        counts[str] = (counts[str] || 0) + 1;
    }

    let distinctCount = 0;
    for (const str of arr) {
        if (counts[str] === 1) {
            distinctCount++;
            if (distinctCount === k) {
                return str;
            }
        }
    }

    return "";
};