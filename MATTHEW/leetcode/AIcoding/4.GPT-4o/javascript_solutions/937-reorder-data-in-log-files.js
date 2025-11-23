var reorderLogs = function(logs) {
    const letterLogs = [];
    const digitLogs = [];

    for (const log of logs) {
        if (/\d/.test(log.split(' ')[1])) {
            digitLogs.push(log);
        } else {
            letterLogs.push(log);
        }
    }

    letterLogs.sort((a, b) => {
        const [aId, ...aContent] = a.split(' ');
        const [bId, ...bContent] = b.split(' ');

        const cmp = aContent.join(' ').localeCompare(bContent.join(' '));
        if (cmp !== 0) return cmp;
        return aId.localeCompare(bId);
    });

    return [...letterLogs, ...digitLogs];
};