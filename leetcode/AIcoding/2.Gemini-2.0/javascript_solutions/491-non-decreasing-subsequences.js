var findSubsequences = function(nums) {
    const result = new Set();
    const n = nums.length;

    function backtrack(index, currentSequence) {
        if (currentSequence.length >= 2) {
            result.add(currentSequence.join(','));
        }

        for (let i = index; i < n; i++) {
            if (currentSequence.length === 0 || nums[i] >= currentSequence[currentSequence.length - 1]) {
                currentSequence.push(nums[i]);
                backtrack(i + 1, currentSequence);
                currentSequence.pop();
            }
        }
    }

    backtrack(0, []);

    const finalResult = [];
    for (const sequenceString of result) {
        finalResult.push(sequenceString.split(',').map(Number));
    }

    return finalResult;
};