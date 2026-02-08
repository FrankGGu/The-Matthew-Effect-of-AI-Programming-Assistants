var largestWordCount = function(messages, senders) {
    const wordCountMap = new Map();
    let maxCount = 0;
    let result = '';

    for (let i = 0; i < messages.length; i++) {
        const sender = senders[i];
        const words = messages[i].split(' ').length;
        const currentCount = (wordCountMap.get(sender) || 0) + words;
        wordCountMap.set(sender, currentCount);

        if (currentCount > maxCount) {
            maxCount = currentCount;
            result = sender;
        } else if (currentCount === maxCount) {
            if (sender > result) {
                result = sender;
            }
        }
    }

    return result;
};