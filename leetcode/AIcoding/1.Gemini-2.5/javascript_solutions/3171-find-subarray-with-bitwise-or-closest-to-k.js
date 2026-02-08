var closestToTarget = function(nums, k) {
    let minDiff = Infinity;
    let currentORs = new Set();

    for (let i = 0; i < nums.length; i++) {
        let newORs = new Set();

        newORs.add(nums[i]);
        minDiff = Math.min(minDiff, Math.abs(nums[i] - k));

        for (let prevOR of currentORs) {
            let combinedOR = prevOR | nums[i];
            newORs.add(combinedOR);
            minDiff = Math.min(minDiff, Math.abs(combinedOR - k));
        }

        currentORs = newORs;
    }

    return minDiff;
};