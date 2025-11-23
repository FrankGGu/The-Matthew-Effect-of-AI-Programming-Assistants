var reorderSpaces = function(text) {
    let spaces = 0;
    let words = [];
    let word = "";
    for (let i = 0; i < text.length; i++) {
        if (text[i] === ' ') {
            spaces++;
            if (word !== "") {
                words.push(word);
                word = "";
            }
        } else {
            word += text[i];
        }
    }
    if (word !== "") {
        words.push(word);
    }

    if (words.length === 1) {
        return words[0] + " ".repeat(spaces);
    }

    let spacesBetween = Math.floor(spaces / (words.length - 1));
    let extraSpaces = spaces % (words.length - 1);

    let result = "";
    for (let i = 0; i < words.length; i++) {
        result += words[i];
        if (i < words.length - 1) {
            result += " ".repeat(spacesBetween);
        }
    }

    result += " ".repeat(extraSpaces);

    return result;
};