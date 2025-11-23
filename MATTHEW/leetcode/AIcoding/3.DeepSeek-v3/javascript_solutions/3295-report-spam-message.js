var reportMessages = function(messages, senders) {
    const spamCount = {};
    let maxCount = 0;
    let result = [];

    for (let i = 0; i < messages.length; i++) {
        const sender = senders[i];
        const words = messages[i].split(' ').length;
        spamCount[sender] = (spamCount[sender] || 0) + words;
    }

    for (const sender in spamCount) {
        if (spamCount[sender] > maxCount) {
            maxCount = spamCount[sender];
            result = [sender];
        } else if (spamCount[sender] === maxCount) {
            result.push(sender);
        }
    }

    result.sort((a, b) => {
        if (a > b) return -1;
        if (a < b) return 1;
        return 0;
    });

    return result[0];
};