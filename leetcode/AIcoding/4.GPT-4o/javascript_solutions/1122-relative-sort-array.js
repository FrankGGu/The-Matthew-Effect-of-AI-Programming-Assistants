var relativeSortArray = function(arr1, arr2) {
    const count = new Map();
    const result = [];

    for (const num of arr1) {
        count.set(num, (count.get(num) || 0) + 1);
    }

    for (const num of arr2) {
        const freq = count.get(num);
        for (let i = 0; i < freq; i++) {
            result.push(num);
        }
        count.delete(num);
    }

    const remaining = Array.from(count.keys()).sort((a, b) => a - b);
    for (const num of remaining) {
        const freq = count.get(num);
        for (let i = 0; i < freq; i++) {
            result.push(num);
        }
    }

    return result;
};