var jump = function(nums) {
    const n = nums.length;
    if (n === 1) {
        return 0;
    }

    let jumps = 0;
    let currentJumpEnd = 0;
    let farthestReach = 0;

    for (let i = 0; i < n - 1; i++) {
        farthestReach = Math.max(farthestReach, i + nums[i]);

        if (i === currentJumpEnd) {
            jumps++;
            currentJumpEnd = farthestReach;

            if (currentJumpEnd >= n - 1) {
                break;
            }
        }
    }

    return jumps;
};