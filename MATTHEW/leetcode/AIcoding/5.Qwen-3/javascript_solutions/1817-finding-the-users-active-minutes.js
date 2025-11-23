function findingUsersActiveMinutes(logs, k) {
    const userActivity = new Map();

    for (const [user, time] of logs) {
        if (!userActivity.has(user)) {
            userActivity.set(user, new Set());
        }
        userActivity.get(user).add(time);
    }

    const result = new Array(k).fill(0);

    for (const [user, times] of userActivity.entries()) {
        const minutes = times.size;
        if (minutes >= 1 && minutes <= k) {
            result[minutes - 1]++;
        }
    }

    return result;
}