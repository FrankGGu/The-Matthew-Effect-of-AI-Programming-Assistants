function smallestPalindromicRearrangementI(s) {
    const charCounts = new Array(26).fill(0);
    for (const char of s) {
        charCounts[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    let oddChar = '';
    let firstHalf = '';

    for (let i = 0; i < 26; i++) {
        const char = String.fromCharCode('a'.charCodeAt(0) + i);
        const count = charCounts[i];

        if (count % 2 === 1) {
            oddChar = char;
        }

        firstHalf += char.repeat(Math.floor(count / 2));
    }

    const reversedFirstHalf = firstHalf.split('').reverse().join('');

    return firstHalf + oddChar + reversedFirstHalf;
}