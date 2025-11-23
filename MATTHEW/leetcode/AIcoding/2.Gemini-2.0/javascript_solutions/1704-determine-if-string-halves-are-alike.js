var halvesAreAlike = function(s) {
    const vowels = ['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'];
    let aCount = 0;
    let bCount = 0;
    const mid = s.length / 2;
    for (let i = 0; i < mid; i++) {
        if (vowels.includes(s[i])) {
            aCount++;
        }
    }
    for (let i = mid; i < s.length; i++) {
        if (vowels.includes(s[i])) {
            bCount++;
        }
    }
    return aCount === bCount;
};