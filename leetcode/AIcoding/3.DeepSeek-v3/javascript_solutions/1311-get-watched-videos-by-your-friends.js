var watchedVideosByFriends = function(watchedVideos, friends, id, level) {
    const queue = [];
    const visited = new Set();
    queue.push(id);
    visited.add(id);
    let currentLevel = 0;

    while (queue.length > 0 && currentLevel < level) {
        const size = queue.length;
        for (let i = 0; i < size; i++) {
            const current = queue.shift();
            for (const friend of friends[current]) {
                if (!visited.has(friend)) {
                    visited.add(friend);
                    queue.push(friend);
                }
            }
        }
        currentLevel++;
    }

    const videoCount = {};
    for (const friend of queue) {
        for (const video of watchedVideos[friend]) {
            videoCount[video] = (videoCount[video] || 0) + 1;
        }
    }

    const sortedVideos = Object.keys(videoCount).sort((a, b) => {
        if (videoCount[a] === videoCount[b]) {
            return a.localeCompare(b);
        } else {
            return videoCount[a] - videoCount[b];
        }
    });

    return sortedVideos;
};