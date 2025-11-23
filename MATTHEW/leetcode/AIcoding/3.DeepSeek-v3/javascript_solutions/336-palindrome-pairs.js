var palindromePairs = function(words) {
    const result = [];
    const wordMap = new Map();

    for (let i = 0; i < words.length; i++) {
        wordMap.set(words[i], i);
    }

    for (let i = 0; i < words.length; i++) {
        const word = words[i];
        const n = word.length;

        for (let j = 0; j <= n; j++) {
            const prefix = word.substring(0, j);
            const suffix = word.substring(j);

            if (isPalindrome(prefix)) {
                const reversedSuffix = suffix.split('').reverse().join('');
                if (wordMap.has(reversedSuffix) && wordMap.get(reversedSuffix) !== i) {
                    result.push([wordMap.get(reversedSuffix), i]);
                }
            }

            if (suffix.length > 0 && isPalindrome(suffix)) {
                const reversedPrefix = prefix.split('').reverse().join('');
                if (wordMap.has(reversedPrefix) && wordMap.get(reversedPrefix) !== i) {
                    result.push([i, wordMap.get(reversedPrefix)]);
                }
            }
        }
    }

    return result;
};

function isPalindrome(s) {
    let left = 0;
    let right = s.length - 1;

    while (left < right) {
        if (s[left] !== s[right]) {
            return false;
        }
        left++;
        right--;
    }

    return true;
}