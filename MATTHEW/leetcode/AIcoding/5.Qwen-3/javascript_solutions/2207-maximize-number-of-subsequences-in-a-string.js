function maxSubs(word, prefix) {
    let count = 0;
    let p1 = 0;
    let p2 = 0;
    const len = word.length;
    const preLen = prefix.length;

    while (p1 < len) {
        if (word[p1] === prefix[p2]) {
            p2++;
            if (p2 === preLen) {
                count++;
                p2 = 0;
            }
        }
        p1++;
    }

    return count;
}