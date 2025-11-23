var countMentions = function(messages) {
    const userMentions = {};

    for (const message of messages) {
        const words = message.split(' ');
        const user = words[0];
        for (let i = 1; i < words.length; i++) {
            if (words[i].startsWith('@')) {
                const mentionedUser = words[i].slice(1);
                userMentions[mentionedUser] = (userMentions[mentionedUser] || 0) + 1;
            }
        }
    }

    const result = {};
    for (const user of Object.keys(userMentions)) {
        result[user] = userMentions[user];
    }

    return result;
};