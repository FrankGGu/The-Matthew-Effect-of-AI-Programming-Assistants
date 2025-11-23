var findRepeatDocument = function(documents) {
    let seen = new Set();
    for (let doc of documents) {
        if (seen.has(doc)) {
            return doc;
        }
        seen.add(doc);
    }
    return -1;
};