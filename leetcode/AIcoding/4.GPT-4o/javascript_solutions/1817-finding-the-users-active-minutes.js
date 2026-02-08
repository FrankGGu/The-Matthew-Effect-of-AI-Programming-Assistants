var findingUsersActiveMinutes = function(logs, k) {
    const userMap = new Map();

    for (const [userId, time] of logs) {
        if (!userMap.has(userId)) {
            userMap.set(userId, new Set());
        }
        userMap.get(userId).add(time);
    }

    const result = new Array(k).fill(0);

    for (const times of userMap.values()) {
        const activeMinutes = times.size;
        result[activeMinutes - 1]++;
    }

    return result;
};