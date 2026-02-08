var findSmallestInteger = function(nums, value) {
    const count = new Array(value).fill(0);
    for (let num of nums) {
        let mod = ((num % value) + value) % value;
        count[mod]++;
    }
    let mex = 0;
    while (count[mex % value] > 0) {
        count[mex % value]--;
        mex++;
    }
    return mex;
};