var distributeElements = function(nums) {
    const arr1 = [];
    const arr2 = [];

    for (const num of nums) {
        if (arr1.length === 0 || num <= arr1[arr1.length - 1]) {
            arr1.push(num);
        } else {
            arr2.push(num);
        }
    }

    return arr1.concat(arr2);
};