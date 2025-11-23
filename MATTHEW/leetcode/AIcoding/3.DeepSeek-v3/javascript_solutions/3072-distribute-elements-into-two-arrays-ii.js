var resultArray = function(nums) {
    const arr1 = [nums[0]];
    const arr2 = [nums[1]];

    for (let i = 2; i < nums.length; i++) {
        const num = nums[i];
        const count1 = arr1.filter(x => x > num).length;
        const count2 = arr2.filter(x => x > num).length;

        if (count1 > count2) {
            arr1.push(num);
        } else if (count1 < count2) {
            arr2.push(num);
        } else {
            if (arr1.length <= arr2.length) {
                arr1.push(num);
            } else {
                arr2.push(num);
            }
        }
    }

    return [...arr1, ...arr2];
};