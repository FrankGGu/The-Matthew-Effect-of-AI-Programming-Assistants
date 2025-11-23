var countMentions = function(tweets) {
    const mentionCount = {};

    for (const tweet of tweets) {
        const mentions = tweet.match(/@(\w+)/g) || [];
        const mentionedUsers = new Set();

        for (const mention of mentions) {
            const username = mention.substring(1);
            mentionedUsers.add(username);
        }

        for (const user of mentionedUsers) {
            if (!mentionCount[user]) {
                mentionCount[user] = 0;
            }
            mentionCount[user]++;
        }
    }

    return mentionCount;
};