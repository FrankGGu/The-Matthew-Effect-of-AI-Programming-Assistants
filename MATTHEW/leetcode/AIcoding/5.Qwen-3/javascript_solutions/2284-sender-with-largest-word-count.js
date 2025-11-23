function largestWordCount(messages, senders) {
    const count = {};
    let maxCount = 0;
    let result = "";

    for (let i = 0; i < messages.length; i++) {
        const words = messages[i].split(" ");
        const wordCount = words.length;
        const sender = senders[i];

        if (!count[sender]) {
            count[sender] = 0;
        }

        count[sender] += wordCount;

        if (count[sender] > maxCount || (count[sender] === maxCount && sender < result)) {
            maxCount = count[sender];
            result = sender;
        }
    }

    return result;
}