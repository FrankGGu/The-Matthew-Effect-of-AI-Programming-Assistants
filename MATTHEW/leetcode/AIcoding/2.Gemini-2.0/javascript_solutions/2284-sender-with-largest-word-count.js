var largestWordCount = function(messages, senders) {
    const wordCounts = {};
    for (let i = 0; i < messages.length; i++) {
        const wordCount = messages[i].split(' ').length;
        if (wordCounts[senders[i]]) {
            wordCounts[senders[i]] += wordCount;
        } else {
            wordCounts[senders[i]] = wordCount;
        }
    }

    let maxCount = 0;
    let senderWithLargestCount = "";

    for (const sender in wordCounts) {
        if (wordCounts[sender] > maxCount) {
            maxCount = wordCounts[sender];
            senderWithLargestCount = sender;
        } else if (wordCounts[sender] === maxCount) {
            if (sender > senderWithLargestCount) {
                senderWithLargestCount = sender;
            }
        }
    }

    return senderWithLargestCount;
};