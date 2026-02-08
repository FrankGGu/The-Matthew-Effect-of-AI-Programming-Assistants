var longestPalindrome = function(words) {
    let count = {};
    let pairs = 0;
    let hasOdd = false;

    for (let word of words) {
        count[word] = (count[word] || 0) + 1;
    }

    for (let word in count) {
        let revWord = word[1] + word[0];
        if (word === revWord) {
            pairs += Math.floor(count[word] / 2);
            if (count[word] % 2 === 1) {
                hasOdd = true;
            }
        } else if (count[revWord]) {
            pairs += Math.min(count[word], count[revWord]);
        }
    }

    return pairs * 4 + (hasOdd ? 2 : 0);
};