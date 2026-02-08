var longestPalindrome = function(words) {
    let count = 0;
    const map = new Map();

    for (const word of words) {
        const reversedWord = word.split("").reverse().join("");
        if (map.has(reversedWord) && map.get(reversedWord) > 0) {
            count += 4;
            map.set(reversedWord, map.get(reversedWord) - 1);
            if (map.get(reversedWord) === 0) {
                map.delete(reversedWord);
            }
        } else {
            if (map.has(word)) {
                map.set(word, map.get(word) + 1);
            } else {
                map.set(word, 1);
            }
        }
    }

    let single = false;
    for (const [word, freq] of map) {
        if (word[0] === word[1] && freq > 0) {
            single = true;
            break;
        }
    }

    if (single) {
        count += 2;
    }

    return count;
};