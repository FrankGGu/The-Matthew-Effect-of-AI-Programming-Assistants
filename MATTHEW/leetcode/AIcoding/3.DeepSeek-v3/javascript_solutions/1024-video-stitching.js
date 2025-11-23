var videoStitching = function(clips, time) {
    clips.sort((a, b) => a[0] - b[0]);
    let res = 0;
    let currentEnd = 0, nextEnd = 0;
    let i = 0, n = clips.length;

    while (currentEnd < time) {
        while (i < n && clips[i][0] <= currentEnd) {
            nextEnd = Math.max(nextEnd, clips[i][1]);
            i++;
        }
        if (currentEnd === nextEnd) return -1;
        currentEnd = nextEnd;
        res++;
    }

    return res;
};