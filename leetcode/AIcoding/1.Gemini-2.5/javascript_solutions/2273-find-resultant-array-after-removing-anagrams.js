var removeAnagrams = function(words) {
    if (words.length === 0) {
        return [];
    }

    const result = [words[0]];

    const getSortedString = (str) => str.split('').sort().join('');

    for (let i = 1; i < words.length; i++) {
        const currentWord = words[i];
        const lastResultWord = result[result.length - 1];

        const sortedCurrent = getSortedString(currentWord);
        const sortedLastResult = getSortedString(lastResultWord);

        if (sortedCurrent !== sortedLastResult) {
            result.push(currentWord);
        }
    }

    return result;
};