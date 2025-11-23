var commonChars = function(words) {
    let result = [];
    let firstWord = words[0].split('');

    for (let char of firstWord) {
        let foundInAll = true;
        for (let i = 1; i < words.length; i++) {
            if (!words[i].includes(char)) {
                foundInAll = false;
                break;
            }
        }
        if (foundInAll) {
            result.push(char);
            for (let i = 1; i < words.length; i++) {
                words[i] = words[i].replace(char, '');
            }
        }
    }

    return result;
};