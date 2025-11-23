var subsetXORSum = function(nums) {
    let total = 0;
    const backtrack = (index, currentXOR) => {
        if (index === nums.length) {
            total += currentXOR;
            return;
        }
        backtrack(index + 1, currentXOR ^ nums[index]);
        backtrack(index + 1, currentXOR);
    };
    backtrack(0, 0);
    return total;
};