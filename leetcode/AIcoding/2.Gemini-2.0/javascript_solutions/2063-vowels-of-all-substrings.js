var countVowels = function(word) {
    let n = word.length;
    let count = 0;
    let vowels = ['a', 'e', 'i', 'o', 'u'];

    for (let i = 0; i < n; i++) {
        if (vowels.includes(word[i])) {
            count += (i + 1) * (n - i);
        }
    }

    return count;
};