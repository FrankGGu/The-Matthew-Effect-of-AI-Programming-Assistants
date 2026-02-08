var frequencySort = function(s) {
    const frequencyMap = {};
    for (const char of s) {
        frequencyMap[char] = (frequencyMap[char] || 0) + 1;
    }

    const sortedChars = Object.keys(frequencyMap).sort((a, b) => frequencyMap[b] - frequencyMap[a]);

    let result = [];
    for (const char of sortedChars) {
        result.push(char.repeat(frequencyMap[char]));
    }

    return result.join('');
};