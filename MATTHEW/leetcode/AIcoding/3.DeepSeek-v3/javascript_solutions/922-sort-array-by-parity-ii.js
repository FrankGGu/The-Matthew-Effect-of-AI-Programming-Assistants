var sortArrayByParityII = function(nums) {
    let even = 0;
    let odd = 1;
    const result = new Array(nums.length);

    for (let num of nums) {
        if (num % 2 === 0) {
            result[even] = num;
            even += 2;
        } else {
            result[odd] = num;
            odd += 2;
        }
    }

    return result;
};