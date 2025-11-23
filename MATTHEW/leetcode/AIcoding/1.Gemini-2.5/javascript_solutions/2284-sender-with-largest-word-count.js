var largestWordCount = function(messages, senders) {
    const senderWordCounts = new Map();

    for (let i = 0; i < messages.length; i++) {
        const message = messages[i];
        const sender = senders[i];
        const wordCount = message.split(' ').length;
        senderWordCounts.set(sender, (senderWordCounts.get(sender) || 0) + wordCount);
    }

    let maxWordCount = -1;
    let resultSender = "";

    for (const [sender, totalWordCount] of senderWordCounts.entries()) {
        if (totalWordCount > maxWordCount) {
            maxWordCount = totalWordCount;
            resultSender = sender;
        } else if (totalWordCount === maxWordCount) {
            if (sender > resultSender) {
                resultSender = sender;
            }
        }
    }

    return resultSender;
};