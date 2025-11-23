var makeSmallestPalindrome = function(s) {
    const n = s.length;
    const counts = new Array(26).fill(0);
    for (let i = 0; i < n; i++) {
        counts[s.charCodeAt(i) - 'a'.charCodeAt(0)]++;
    }

    let oddCount = 0;
    let oddChar = -1;
    for (let i = 0; i < 26; i++) {
        if (counts[i] % 2 !== 0) {
            oddCount++;
            oddChar = i;
        }
    }

    if (oddCount > 1) {
        return "";
    }

    let left = "";
    let right = "";
    for (let i = 0; i < 26; i++) {
        let char = String.fromCharCode('a'.charCodeAt(0) + i);
        let count = counts[i] / 2;
        left += char.repeat(count);
        right = char.repeat(count) + right;
    }

    let middle = "";
    if (oddChar !== -1) {
        middle = String.fromCharCode('a'.charCodeAt(0) + oddChar);
    }

    return left + middle + right;
};