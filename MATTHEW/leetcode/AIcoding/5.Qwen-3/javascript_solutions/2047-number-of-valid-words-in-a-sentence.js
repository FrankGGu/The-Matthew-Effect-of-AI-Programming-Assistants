function countValidWords(sentence) {
    let count = 0;
    const words = sentence.split(' ');
    for (const word of words) {
        if (word.length === 0) continue;
        let valid = true;
        let hyphenCount = 0;
        for (let i = 0; i < word.length; i++) {
            const c = word[i];
            if (c >= 'a' && c <= 'z') continue;
            if (c === '-') {
                hyphenCount++;
                if (hyphenCount > 1 || i === 0 || i === word.length - 1) {
                    valid = false;
                    break;
                }
                if (i > 0 && i < word.length - 1 && (word[i - 1] >= 'a' && word[i - 1] <= 'z') && (word[i + 1] >= 'a' && word[i + 1] <= 'z')) continue;
                else {
                    valid = false;
                    break;
                }
            } else {
                valid = false;
                break;
            }
        }
        if (valid) count++;
    }
    return count;
}