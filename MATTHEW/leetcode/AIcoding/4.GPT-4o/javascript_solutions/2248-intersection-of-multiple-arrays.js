var intersection = function(arrays) {
    const count = {};
    const result = [];
    const n = arrays.length;

    for (const array of arrays) {
        const uniqueElements = new Set(array);
        for (const num of uniqueElements) {
            count[num] = (count[num] || 0) + 1;
        }
    }

    for (const num in count) {
        if (count[num] === n) {
            result.push(Number(num));
        }
    }

    return result;
};