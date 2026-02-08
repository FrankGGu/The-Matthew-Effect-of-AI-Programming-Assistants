var getMaxLen = function(nums) {
    let pos = 0, neg = 0, ans = 0;
    for (let num of nums) {
        if (num > 0) {
            pos++;
            neg = neg > 0 ? neg + 1 : 0;
        } else if (num < 0) {
            let temp = pos;
            pos = neg > 0 ? neg + 1 : 0;
            neg = temp + 1;
        } else {
            pos = 0;
            neg = 0;
        }
        ans = Math.max(ans, pos);
    }
    return ans;
};