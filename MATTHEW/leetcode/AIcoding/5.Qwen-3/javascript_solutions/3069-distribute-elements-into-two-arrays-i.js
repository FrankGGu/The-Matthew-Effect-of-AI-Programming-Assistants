function distributeElementsIntoTwoArrays(nums) {
    const arr1 = [];
    const arr2 = [];

    for (const num of nums) {
        if (arr1.length <= arr2.length) {
            arr1.push(num);
        } else {
            arr2.push(num);
        }
    }

    return [...arr1, ...arr2];
}