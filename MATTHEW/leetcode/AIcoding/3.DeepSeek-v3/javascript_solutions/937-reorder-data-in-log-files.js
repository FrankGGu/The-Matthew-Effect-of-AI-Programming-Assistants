var reorderLogFiles = function(logs) {
    const letterLogs = [];
    const digitLogs = [];

    for (const log of logs) {
        const parts = log.split(' ');
        if (isNaN(parts[1])) {
            letterLogs.push(log);
        } else {
            digitLogs.push(log);
        }
    }

    letterLogs.sort((a, b) => {
        const aContent = a.substring(a.indexOf(' ') + 1);
        const bContent = b.substring(b.indexOf(' ') + 1);
        if (aContent === bContent) {
            return a.localeCompare(b);
        }
        return aContent.localeCompare(bContent);
    });

    return [...letterLogs, ...digitLogs];
};