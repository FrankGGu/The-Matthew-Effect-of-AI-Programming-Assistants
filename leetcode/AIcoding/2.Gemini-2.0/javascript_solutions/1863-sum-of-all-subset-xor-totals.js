var subsetXORSum = function(nums) {
    let sum = 0;
    function backtrack(index, currentXOR) {
        if (index === nums.length) {
            sum += currentXOR;
            return;
        }

        backtrack(index + 1, currentXOR ^ nums[index]);
        backtrack(index + 1, currentXOR);
    }

    backtrack(0, 0);
    return sum;
};