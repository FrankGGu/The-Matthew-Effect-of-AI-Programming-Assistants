var watchedVideosByFriends = function(watchedVideos, friends, id, level) {
    const n = friends.length;
    const queue = [[id, 0]];
    const visited = new Set([id]);
    const friendsAtLevelK = [];

    let head = 0;
    while(head < queue.length) {
        const [currentId, currentLevel] = queue[head++];

        if (currentLevel === level) {
            friendsAtLevelK.push(currentId);
            continue; 
        }

        if (currentLevel > level) {
            break; 
        }

        for (const friendId of friends[currentId]) {
            if (!visited.has(friendId)) {
                visited.add(friendId);
                queue.push([friendId, currentLevel + 1]);
            }
        }
    }

    const videoFrequencies = new Map();
    for (const friendId of friendsAtLevelK) {
        for (const video of watchedVideos[friendId]) {
            videoFrequencies.set(video, (videoFrequencies.get(video) || 0) + 1);
        }
    }

    const result = Array.from(videoFrequencies.entries());

    result.sort((a, b) => {
        if (a[1] !== b[1]) {
            return a[1] - b[1];
        }
        return a[0].localeCompare(b[0]);
    });

    return result.map(entry => entry[0]);
};