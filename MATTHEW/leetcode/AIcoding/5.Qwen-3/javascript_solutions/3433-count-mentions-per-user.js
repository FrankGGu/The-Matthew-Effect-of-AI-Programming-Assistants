function countMentionsPerUser(mentions) {
    const userCounts = {};

    for (const mention of mentions) {
        const match = mention.match(/@(\w+)/);
        if (match && match[1]) {
            const username = match[1];
            userCounts[username] = (userCounts[username] || 0) + 1;
        }
    }

    return userCounts;
}