function getWatchedVideosByYourFriends(friends, id, k) {
    const visited = new Set();
    const queue = [id];
    visited.add(id);
    const result = [];

    while (queue.length > 0) {
        const current = queue.shift();
        for (const friend of friends[current]) {
            if (!visited.has(friend)) {
                visited.add(friend);
                queue.push(friend);
            }
        }
    }

    const videoMap = new Map();

    for (const friend of visited) {
        for (const video of friends[friend]) {
            videoMap.set(video, (videoMap.get(video) || 0) + 1);
        }
    }

    const sortedVideos = Array.from(videoMap.entries()).sort((a, b) => {
        if (b[1] !== a[1]) return b[1] - a[1];
        return a[0].localeCompare(b[0]);
    });

    const finalResult = [];
    for (let i = 0; i < k && i < sortedVideos.length; i++) {
        finalResult.push(sortedVideos[i][0]);
    }

    return finalResult;
}