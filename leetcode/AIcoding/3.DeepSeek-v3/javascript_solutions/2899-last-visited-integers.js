var lastVisitedIntegers = function(words) {
    let nums = [];
    let result = [];
    let k = 0;

    for (let i = 0; i < words.length; i++) {
        if (words[i] === "prev") {
            k++;
            if (k <= nums.length) {
                result.push(nums[nums.length - k]);
            } else {
                result.push(-1);
            }
        } else {
            nums.push(parseInt(words[i]));
            k = 0;
        }
    }

    return result;
};