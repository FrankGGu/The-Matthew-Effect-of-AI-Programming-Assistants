function videoStitching(clips, time) {
    clips.sort((a, b) => a[0] - b[0] || a[1] - b[1]);
    let res = 0;
    let i = 0;
    let last = 0;
    while (last < time) {
        let maxEnd = last;
        while (i < clips.length && clips[i][0] <= last) {
            maxEnd = Math.max(maxEnd, clips[i][1]);
            i++;
        }
        if (maxEnd === last) return -1;
        last = maxEnd;
        res++;
    }
    return res;
}