var reorderLogFiles = function(logs) {
    const digitLogs = [];
    const letterLogs = [];

    for (const log of logs) {
        const parts = log.split(' ');
        if (isNaN(parseInt(parts[1]))) {
            letterLogs.push(log);
        } else {
            digitLogs.push(log);
        }
    }

    letterLogs.sort((a, b) => {
        const aParts = a.split(' ');
        const bParts = b.split(' ');
        const aIdentifier = aParts.slice(1).join(' ');
        const bIdentifier = bParts.slice(1).join(' ');

        if (aIdentifier === bIdentifier) {
            return aParts[0].localeCompare(bParts[0]);
        } else {
            return aIdentifier.localeCompare(bIdentifier);
        }
    });

    return letterLogs.concat(digitLogs);
};