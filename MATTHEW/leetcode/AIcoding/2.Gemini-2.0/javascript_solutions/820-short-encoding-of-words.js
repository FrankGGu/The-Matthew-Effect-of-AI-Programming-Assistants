var minimumLengthEncoding = function(words) {
    words.sort((a, b) => b.length - a.length);
    let s = "";
    for (let word of words) {
        if (!s.includes(word + "#")) {
            s += word + "#";
        }
    }
    return s.length;
};