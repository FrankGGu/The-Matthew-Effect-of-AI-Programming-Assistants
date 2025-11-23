var maximumNumberOfStringPairs = function(words) {
    let count = 0;
    let seen = new Set();
    for (let i = 0; i < words.length; i++) {
        let reversed = words[i].split("").reverse().join("");
        if (seen.has(reversed)) {
            count++;
        } else {
            seen.add(words[i]);
        }
    }
    return count;
};