var minimumLengthEncoding = function(words) {
    words.sort((a, b) => b.length - a.length);
    let encoded = "";
    for (let word of words) {
        if (!encoded.includes(word + "#")) {
            encoded += word + "#";
        }
    }
    return encoded.length;
};