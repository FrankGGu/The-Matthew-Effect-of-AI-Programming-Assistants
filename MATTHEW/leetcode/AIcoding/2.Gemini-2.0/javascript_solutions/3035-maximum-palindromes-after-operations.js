var maxPalindromesAfterOperations = function(words) {
    const counts = new Array(26).fill(0);
    let totalLength = 0;
    for (const word of words) {
        totalLength += word.length;
        for (const char of word) {
            counts[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
        }
    }

    let pairs = 0;
    for (const count of counts) {
        pairs += Math.floor(count / 2);
    }

    words.sort((a, b) => a.length - b.length);

    let ans = 0;
    for (const word of words) {
        const len = word.length;
        if (pairs >= Math.floor(len / 2)) {
            pairs -= Math.floor(len / 2);
            ans++;
        } else {
            break;
        }
    }

    return ans;
};