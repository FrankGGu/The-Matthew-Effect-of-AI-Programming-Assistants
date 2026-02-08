var countMentions = function(data) {
    const mentions = {};

    for (const entry of data) {
        const [user, mention] = entry.split(', ');
        if (!mentions[user]) {
            mentions[user] = new Set();
        }
        mentions[user].add(mention);
    }

    const result = [];
    for (const user in mentions) {
        result.push([user, mentions[user].size.toString()]);
    }

    return result;
};