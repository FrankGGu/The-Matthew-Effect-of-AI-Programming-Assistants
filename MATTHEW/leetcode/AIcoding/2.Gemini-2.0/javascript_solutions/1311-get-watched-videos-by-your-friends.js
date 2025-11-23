var watchedVideosByFriends = function(watchedVideos, friends, id, level) {
    const n = watchedVideos.length;
    const visited = new Array(n).fill(false);
    const queue = [id];
    visited[id] = true;
    let currentLevel = 0;
    let friendsAtLevel = [];

    while (queue.length > 0 && currentLevel < level) {
        const size = queue.length;
        for (let i = 0; i < size; i++) {
            const currentFriend = queue.shift();
            for (const friend of friends[currentFriend]) {
                if (!visited[friend]) {
                    visited[friend] = true;
                    queue.push(friend);
                }
            }
        }
        currentLevel++;
    }

    friendsAtLevel = queue;

    const videos = [];
    for (const friend of friendsAtLevel) {
        videos.push(...watchedVideos[friend]);
    }

    const videoCounts = {};
    for (const video of videos) {
        videoCounts[video] = (videoCounts[video] || 0) + 1;
    }

    const sortedVideos = Object.keys(videoCounts).sort((a, b) => {
        if (videoCounts[a] !== videoCounts[b]) {
            return videoCounts[a] - videoCounts[b];
        } else {
            return a.localeCompare(b);
        }
    });

    return sortedVideos;
};