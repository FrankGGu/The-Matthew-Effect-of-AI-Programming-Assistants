var findingUsersActiveMinutes = function(logs, k) {
    const userMap = new Map();

    for (const [id, time] of logs) {
        if (!userMap.has(id)) {
            userMap.set(id, new Set());
        }
        userMap.get(id).add(time);
    }

    const result = new Array(k).fill(0);

    for (const [id, times] of userMap) {
        const uam = times.size;
        if (uam <= k) {
            result[uam - 1]++;
        }
    }

    return result;
};