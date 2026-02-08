var intersection = function(nums) {
    let count = {};
    for (let arr of nums) {
        for (let num of arr) {
            if (count[num]) {
                count[num]++;
            } else {
                count[num] = 1;
            }
        }
    }
    let result = [];
    for (let key in count) {
        if (count[key] === nums.length) {
            result.push(parseInt(key));
        }
    }
    return result.sort((a, b) => a - b);
};