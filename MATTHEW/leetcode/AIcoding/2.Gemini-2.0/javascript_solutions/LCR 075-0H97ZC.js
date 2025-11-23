var relativeSortArray = function(arr1, arr2) {
    const result = [];
    const remaining = [];
    const count = {};

    for (const num of arr1) {
        count[num] = (count[num] || 0) + 1;
    }

    for (const num of arr2) {
        if (count[num]) {
            for (let i = 0; i < count[num]; i++) {
                result.push(num);
            }
            delete count[num];
        }
    }

    for (const num in count) {
        if (count.hasOwnProperty(num)) {
            for (let i = 0; i < count[num]; i++) {
                remaining.push(parseInt(num));
            }
        }
    }

    remaining.sort((a, b) => a - b);

    return result.concat(remaining);
};