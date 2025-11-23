var jump = function(height) {
    let jumps = 0;
    let currentReach = 0;
    let maxReach = 0;

    for (let i = 0; i < height.length - 1; i++) {
        maxReach = Math.max(maxReach, i + height[i]);

        if (i === currentReach) {
            jumps++;
            currentReach = maxReach;

            if (currentReach >= height.length - 1) {
                break;
            }
        }
    }

    return jumps;
};