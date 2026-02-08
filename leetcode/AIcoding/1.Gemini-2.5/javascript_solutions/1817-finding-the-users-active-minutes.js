var findingUsersActiveMinutes = function(logs, k) {
    const userActivity = new Map();

    for (const [userId, minute] of logs) {
        if (!userActivity.has(userId)) {
            userActivity.set(userId, new Set());
        }
        userActivity.get(userId).add(minute);
    }

    const answer = new Array(k + 1).fill(0);

    for (const minutesSet of userActivity.values()) {
        const uam = minutesSet.size;
        if (uam >= 1 && uam <= k) {
            answer[uam]++;
        }
    }

    return answer;
};