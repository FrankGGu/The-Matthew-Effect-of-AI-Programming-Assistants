function findOcurrences(text, first, second) {
    const result = [];
    const words = text.split(' ');
    for (let i = 0; i < words.length - 2; i++) {
        if (words[i] === first && words[i + 1] === second) {
            result.push(words[i + 2]);
        }
    }
    return result;
}