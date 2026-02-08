function countMentionsPerUser(tweets) {
    const mentionsByUser = {};
    const mentionRegex = /@([a-zA-Z0-9_]+)/g;

    for (const tweetObj of tweets) {
        const authorId = tweetObj.userId;
        const tweetContent = tweetObj.tweet;

        let match;
        while ((match = mentionRegex.exec(tweetContent)) !== null) {
            const mentionedUser = match[1];

            if (!mentionsByUser[authorId]) {
                mentionsByUser[authorId] = {};
            }
            mentionsByUser[authorId][mentionedUser] = (mentionsByUser[authorId][mentionedUser] || 0) + 1;
        }
    }

    return mentionsByUser;
}