var largestWordCount = function(messages, senders) {
    let maxCount = 0;
    let senderCount = new Map();

    for (let i = 0; i < messages.length; i++) {
        let count = messages[i].split(' ').length;
        senderCount.set(senders[i], (senderCount.get(senders[i]) || 0) + count);
        if (senderCount.get(senders[i]) > maxCount) {
            maxCount = senderCount.get(senders[i]);
        }
    }

    let result = '';
    for (let [sender, count] of senderCount.entries()) {
        if (count === maxCount) {
            if (result === '' || sender > result) {
                result = sender;
            }
        }
    }

    return result;
};