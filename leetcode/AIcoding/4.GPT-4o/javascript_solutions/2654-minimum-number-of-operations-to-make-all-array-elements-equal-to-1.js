var minOperations = function(nums) {
    let cnt = 0;
    let maxNum = 0;
    for (let num of nums) {
        if (num > 1) {
            cnt += num - 1;
            maxNum = Math.max(maxNum, num);
        }
    }
    return cnt + (maxNum > 1 ? 1 : 0);
};