var relativeSortArray = function(arr1, arr2) {
    const count = new Map();
    const result = [];

    for (let num of arr1) {
        count.set(num, (count.get(num) || 0) + 1);
    }

    for (let num of arr2) {
        if (count.has(num)) {
            result.push(...Array(count.get(num)).fill(num));
            count.delete(num);
        }
    }

    const remaining = Array.from(count.keys()).sort((a, b) => a - b);

    for (let num of remaining) {
        result.push(...Array(count.get(num)).fill(num));
    }

    return result;
};