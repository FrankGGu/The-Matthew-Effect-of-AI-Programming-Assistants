var reorderLogFiles = function(logs) {
    const letterLogs = [];
    const digitLogs = [];

    for (const log of logs) {
        const parts = log.split(' ');
        // Check the first character of the content part (second word)
        // If it's a digit, it's a digit-log. Otherwise, it's a letter-log.
        if (parts[1][0] >= '0' && parts[1][0] <= '9') {
            digitLogs.push(log);
        } else {
            letterLogs.push(log);
        }
    }

    letterLogs.sort((a, b) => {
        const aParts = a.split(' ');
        const bParts = b.split(' ');

        const aIdentifier = aParts[0];
        const bIdentifier = bParts[0];

        // Get the content part (all words after the identifier)
        const aContent = aParts.slice(1).join(' ');
        const bContent = bParts.slice(1).join(' ');

        // Compare content first
        if (aContent < bContent) {
            return -1;
        }
        if (aContent > bContent) {
            return 1;
        }

        // If content is the same, compare identifiers
        if (aIdentifier < bIdentifier) {
            return -1;
        }
        if (aIdentifier > bIdentifier) {
            return 1;
        }

        // If both content and identifier are the same, their relative order doesn't matter
        return 0;
    });

    // Concatenate sorted letter-logs and original order digit-logs
    return [...letterLogs, ...digitLogs];
};