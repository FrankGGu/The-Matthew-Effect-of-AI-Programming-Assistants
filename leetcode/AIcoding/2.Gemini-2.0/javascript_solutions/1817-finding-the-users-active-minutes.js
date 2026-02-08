var findingUsersActiveMinutes = function(logs, k) {
    const userActivity = new Map();
    for (const [id, time] of logs) {
        if (!userActivity.has(id)) {
            userActivity.set(id, new Set());
        }
        userActivity.get(id).add(time);
    }

    const result = new Array(k).fill(0);
    for (const activeMinutes of userActivity.values()) {
        result[activeMinutes.size - 1]++;
    }

    return result;
};