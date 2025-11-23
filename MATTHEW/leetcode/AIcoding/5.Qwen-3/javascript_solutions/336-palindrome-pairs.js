function palindromePairs(words) {
    const n = words.length;
    const result = [];
    const wordMap = new Map();

    for (let i = 0; i < n; i++) {
        wordMap.set(words[i], i);
    }

    for (let i = 0; i < n; i++) {
        const word = words[i];
        const len = word.length;

        for (let j = 0; j <= len; j++) {
            const prefix = word.substring(0, j);
            const suffix = word.substring(j);

            if (isPalindrome(suffix)) {
                const reversePrefix = prefix.split('').reverse().join('');
                if (wordMap.has(reversePrefix) && wordMap.get(reversePrefix) !== i) {
                    result.push([i, wordMap.get(reversePrefix)]);
                }
            }

            if (isPalindrome(prefix)) {
                const reverseSuffix = suffix.split('').reverse().join('');
                if (wordMap.has(reverseSuffix) && wordMap.get(reverseSuffix) !== i) {
                    result.push([wordMap.get(reverseSuffix), i]);
                }
            }
        }
    }

    return result;
}

function isPalindrome(s) {
    let left = 0;
    let right = s.length - 1;
    while (left < right) {
        if (s[left] !== s[right]) return false;
        left++;
        right--;
    }
    return true;
}