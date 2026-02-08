function solve(s) {
    const freq = new Array(26).fill(0);
    for (let i = 0; i < s.length; i++) {
        freq[s.charCodeAt(i) - 'a'.charCodeAt(0)]++;
    }

    let middleChar = '';
    const oddCharsIndices = [];

    for (let i = 0; i < 26; i++) {
        if (freq[i] % 2 === 1) {
            oddCharsIndices.push(i);
        }
    }

    if (oddCharsIndices.length > 0) {
        middleChar = String.fromCharCode('a'.charCodeAt(0) + oddCharsIndices[0]);
        freq[oddCharsIndices[0]]--; 
    }

    for (let i = 1; i < oddCharsIndices.length; i++) {
        freq[oddCharsIndices[i]]--; 
    }

    const leftHalfChars = [];
    for (let i = 0; i < 26; i++) {
        const char = String.fromCharCode('a'.charCodeAt(0) + i);
        for (let j = 0; j < freq[i] / 2; j++) {
            leftHalfChars.push(char);
        }
    }

    const left = leftHalfChars.join('');
    const reversedLeft = leftHalfChars.reverse().join(''); 

    return left + middleChar + reversedLeft;
}