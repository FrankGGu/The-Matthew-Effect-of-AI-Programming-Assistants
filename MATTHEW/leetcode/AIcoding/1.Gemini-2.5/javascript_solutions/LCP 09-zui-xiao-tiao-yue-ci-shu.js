var jump = function(nums) {
    let n = nums.length;
    if (n === 1) {
        return 0;
    }

    let jumps = 0;
    let currentJumpEnd = 0;
    let farthest = 0;

    for (let i = 0; i < n - 1; i++) {
        farthest = Math.max(farthest, i + nums[i]);

        if (i === currentJumpEnd) {
            jumps++;
            currentJumpEnd = farthest;
            if (currentJumpEnd >= n - 1) {
                break;
            }
        }
    }

    return jumps;
};