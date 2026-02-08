var removeAnagrams = function(words) {
    const result = [];
    let prevAnagram = '';

    for (let word of words) {
        const sortedWord = word.split('').sort().join('');
        if (sortedWord !== prevAnagram) {
            result.push(word);
            prevAnagram = sortedWord;
        }
    }

    return result;
};