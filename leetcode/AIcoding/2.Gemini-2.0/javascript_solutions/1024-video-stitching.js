var videoStitching = function(clips, time) {
    clips.sort((a, b) => a[0] - b[0] || b[1] - a[1]);

    let count = 0;
    let currentEnd = 0;
    let farthestReach = 0;

    for (let i = 0; i < clips.length; i++) {
        if (clips[i][0] > currentEnd) {
            if (currentEnd === farthestReach) {
                return -1;
            }
            currentEnd = farthestReach;
            count++;
        }
        farthestReach = Math.max(farthestReach, clips[i][1]);
        if (farthestReach >= time) {
            return count + 1;
        }
    }

    if (farthestReach < time) {
        if (currentEnd === farthestReach) return -1;

         if (farthestReach >= time) return count + 1;

        if (currentEnd < time && farthestReach >= time){
            return count + 1;
        }

        if (farthestReach < time){
                if (currentEnd === farthestReach) return -1;
        }

        return -1;
    }

    return count + (currentEnd < time ? 1 : 0);
};