var findMinimumTime = function(rooms) {
    let currentTime = 0;
    for (let i = 0; i < rooms.length; i++) {
        const [arrivalTime, clearTime] = rooms[i];
        currentTime = Math.max(currentTime, arrivalTime) + clearTime;
    }
    return currentTime;
};