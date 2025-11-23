var watchedVideosByFriends = function(watchedVideos, friends, id, level) {
    const n = watchedVideos.length;
    const graph = Array.from({ length: n }, () => []);
    const visited = new Set();
    const queue = [[id, 0]];

    while (queue.length) {
        const [currentId, currentLevel] = queue.shift();
        if (currentLevel === level) continue;
        visited.add(currentId);

        for (const friend of friends[currentId]) {
            if (!visited.has(friend)) {
                queue.push([friend, currentLevel + 1]);
            }
        }
    }

    const videoCount = {};
    for (const [currentId] of queue) {
        for (const video of watchedVideos[currentId]) {
            if (!videoCount[video]) {
                videoCount[video] = 0;
            }
            videoCount[video]++;
        }
    }

    return Object.keys(videoCount).sort((a, b) => {
        if (videoCount[a] === videoCount[b]) {
            return a.localeCompare(b);
        }
        return videoCount[a] - videoCount[b];
    });
};