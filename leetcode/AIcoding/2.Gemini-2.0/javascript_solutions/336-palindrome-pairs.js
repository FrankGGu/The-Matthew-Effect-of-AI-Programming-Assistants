var palindromePairs = function(words) {
    const result = [];
    const wordMap = new Map();

    for (let i = 0; i < words.length; i++) {
        wordMap.set(words[i], i);
    }

    for (let i = 0; i < words.length; i++) {
        const word = words[i];
        for (let j = 0; j <= word.length; j++) {
            const left = word.substring(0, j);
            const right = word.substring(j);

            if (isPalindrome(left)) {
                const reversedRight = right.split("").reverse().join("");
                if (wordMap.has(reversedRight) && wordMap.get(reversedRight) !== i) {
                    result.push([wordMap.get(reversedRight), i]);
                }
            }

            if (right.length > 0 && isPalindrome(right)) {
                const reversedLeft = left.split("").reverse().join("");
                if (wordMap.has(reversedLeft) && wordMap.get(reversedLeft) !== i) {
                    result.push([i, wordMap.get(reversedLeft)]);
                }
            }
        }
    }

    return result;

    function isPalindrome(str) {
        let left = 0;
        let right = str.length - 1;
        while (left < right) {
            if (str[left] !== str[right]) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    }
};