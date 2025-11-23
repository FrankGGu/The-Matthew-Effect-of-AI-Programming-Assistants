var minimumLengthEncoding = function(words) {
    let set = new Set(words);
    for (let word of set) {
        for (let i = 1; i < word.length; i++) {
            let suffix = word.slice(i);
            set.has(suffix) && set.delete(suffix);
        }
    }
    let res = 0;
    set.forEach(word => res += word.length + 1);
    return res;
};