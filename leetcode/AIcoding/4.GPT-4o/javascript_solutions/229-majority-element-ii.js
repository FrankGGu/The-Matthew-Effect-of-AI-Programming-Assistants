var majorityElement = function(nums) {
    const count = {};
    const result = [];
    const threshold = Math.floor(nums.length / 3);

    for (let num of nums) {
        count[num] = (count[num] || 0) + 1;
        if (count[num] === threshold + 1) {
            result.push(num);
        }
    }

    return result;
};