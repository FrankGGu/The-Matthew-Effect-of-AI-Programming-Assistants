var relativeSortArray = function(arr1, arr2) {
    const result = [];
    const remaining = [];

    for (const num of arr2) {
        while (arr1.includes(num)) {
            result.push(num);
            arr1.splice(arr1.indexOf(num), 1);
        }
    }

    remaining.push(...arr1);
    remaining.sort((a, b) => a - b);

    return result.concat(remaining);
};