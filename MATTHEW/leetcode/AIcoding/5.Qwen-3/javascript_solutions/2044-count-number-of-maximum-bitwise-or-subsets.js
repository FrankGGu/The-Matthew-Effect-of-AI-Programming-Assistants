function countMaxOrSubsets(nums) {
    let maxOr = 0;
    for (let num of nums) {
        maxOr |= num;
    }

    let count = 0;
    const n = nums.length;

    function backtrack(index, currentOr) {
        if (index === n) {
            if (currentOr === maxOr) {
                count++;
            }
            return;
        }

        backtrack(index + 1, currentOr);
        backtrack(index + 1, currentOr | nums[index]);
    }

    backtrack(0, 0);
    return count;
}