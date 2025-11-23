var palindromePairs = function(words) {
    const result = [];
    const wordMap = new Map();

    for (let i = 0; i < words.length; i++) {
        wordMap.set(words[i], i);
    }

    for (let i = 0; i < words.length; i++) {
        const word = words[i];
        const reversedWord = word.split('').reverse().join('');

        if (wordMap.has(reversedWord) && wordMap.get(reversedWord) !== i) {
            result.push([i, wordMap.get(reversedWord)]);
        }

        for (let j = 1; j < word.length; j++) {
            const left = word.slice(0, j);
            const right = word.slice(j);
            if (isPalindrome(left) && wordMap.has(reversedWord.slice(0, word.length - j))) {
                result.push([wordMap.get(reversedWord.slice(0, word.length - j)), i]);
            }
            if (isPalindrome(right) && wordMap.has(reversedWord.slice(j))) {
                result.push([i, wordMap.get(reversedWord.slice(j))]);
            }
        }
    }

    return result;
};

function isPalindrome(s) {
    let left = 0, right = s.length - 1;
    while (left < right) {
        if (s[left] !== s[right]) return false;
        left++;
        right--;
    }
    return true;
}