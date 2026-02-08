var findTheDifference = function(s, t) {
    let charCount = new Array(26).fill(0);

    for (let char of t) {
        charCount[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    for (let char of s) {
        charCount[char.charCodeAt(0) - 'a'.charCodeAt(0)]--;
    }

    for (let i = 0; i < 26; i++) {
        if (charCount[i] === 1) {
            return String.fromCharCode(i + 'a'.charCodeAt(0));
        }
    }
};