var videoStitching = function(clips, T) {
    clips.sort((a, b) => a[0] - b[0]);
    let count = 0, end = 0, farthest = 0, i = 0;

    while (end < T) {
        while (i < clips.length && clips[i][0] <= end) {
            farthest = Math.max(farthest, clips[i][1]);
            i++;
        }
        if (end === farthest) return -1;
        end = farthest;
        count++;
    }

    return count;
};