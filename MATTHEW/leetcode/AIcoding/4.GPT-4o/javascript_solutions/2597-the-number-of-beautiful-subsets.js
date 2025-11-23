function beautifulSubsets(nums, k) {
    const n = nums.length;
    let count = 0;

    function backtrack(index, currentSubset) {
        if (index === n) {
            count++;
            return;
        }
        backtrack(index + 1, currentSubset);
        currentSubset.push(nums[index]);
        if (!currentSubset.includes(nums[index] + k) && !currentSubset.includes(nums[index] - k)) {
            backtrack(index + 1, currentSubset);
        }
        currentSubset.pop();
    }

    backtrack(0, []);
    return count - 1; // exclude the empty subset
}