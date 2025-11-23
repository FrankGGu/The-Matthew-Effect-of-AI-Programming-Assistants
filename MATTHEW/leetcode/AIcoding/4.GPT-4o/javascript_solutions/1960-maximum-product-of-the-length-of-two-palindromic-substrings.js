var maxProduct = function(words) {
    const isPalindrome = str => {
        let left = 0, right = str.length - 1;
        while (left < right) {
            if (str[left] !== str[right]) return false;
            left++;
            right--;
        }
        return true;
    };

    const palindromicWords = words.filter(isPalindrome);
    const n = palindromicWords.length;
    let maxProd = 0;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            if (!hasCommonLetters(palindromicWords[i], palindromicWords[j])) {
                maxProd = Math.max(maxProd, palindromicWords[i].length * palindromicWords[j].length);
            }
        }
    }

    return maxProd;
};

const hasCommonLetters = (word1, word2) => {
    const set1 = new Set(word1);
    for (const char of word2) {
        if (set1.has(char)) return true;
    }
    return false;
};