var videoStitching = function(clips, time) {
    clips.sort((a, b) => a[0] - b[0]);

    let n = clips.length;
    let clipsUsed = 0;
    let currentEnd = 0;
    let maxReach = 0;
    let i = 0;

    while (currentEnd < time) {
        clipsUsed++;
        maxReach = currentEnd;

        while (i < n && clips[i][0] <= currentEnd) {
            maxReach = Math.max(maxReach, clips[i][1]);
            i++;
        }

        if (maxReach <= currentEnd) { // Using <= instead of == for robustness, though == is sufficient here
            return -1;
        }

        currentEnd = maxReach;
    }

    return clipsUsed;
};