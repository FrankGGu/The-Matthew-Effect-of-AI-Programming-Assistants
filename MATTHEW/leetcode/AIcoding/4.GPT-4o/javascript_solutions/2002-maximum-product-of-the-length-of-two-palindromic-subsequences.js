function maxProduct(words) {
    const isPalindrome = (word) => {
        let left = 0, right = word.length - 1;
        while (left < right) {
            if (word[left] !== word[right]) return false;
            left++;
            right--;
        }
        return true;
    };

    const palindromicWords = words.map(word => isPalindrome(word));

    let maxProduct = 0;
    for (let i = 0; i < words.length; i++) {
        if (!palindromicWords[i]) continue;
        for (let j = i + 1; j < words.length; j++) {
            if (palindromicWords[j]) {
                maxProduct = Math.max(maxProduct, words[i].length * words[j].length);
            }
        }
    }

    return maxProduct;
}