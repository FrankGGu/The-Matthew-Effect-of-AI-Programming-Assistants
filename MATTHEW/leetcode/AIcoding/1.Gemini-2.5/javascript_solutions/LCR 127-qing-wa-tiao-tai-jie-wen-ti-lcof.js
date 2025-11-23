var jump = function(nums) {
    const n = nums.length;
    if (n === 1) {
        return 0;
    }

    let jumps = 0;
    let currentEnd = 0; // The farthest point reachable with the current number of jumps
    let farthest = 0;   // The farthest point reachable from any position within the current jump's range

    for (let i = 0; i < n - 1; i++) {
        // Update the farthest reach from the current position
        farthest = Math.max(farthest, i + nums[i]);

        // If we have reached the end of the current jump's range
        if (i === currentEnd) {
            jumps++;
            currentEnd = farthest; // Set the new end for the next jump

            // If the new currentEnd already covers or exceeds the last index, we can stop
            if (currentEnd >= n - 1) {
                break;
            }
        }
    }

    return jumps;
};