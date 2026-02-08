var getSmallestString = function(n, k) {
    const result = [];
    for (let i = 0; i < n; i++) {
        const remainingPositions = n - 1 - i;

        // Calculate the minimum possible value for the current character.
        // This value must be at least 1 ('a').
        // It must also be large enough such that the remaining 'k' can be formed by 'remainingPositions' characters,
        // where each of those can be at most 'z' (value 26).
        // So, k - charValue <= remainingPositions * 26
        // => charValue >= k - remainingPositions * 26
        const charValue = Math.max(1, k - remainingPositions * 26);

        result.push(String.fromCharCode('a'.charCodeAt(0) + charValue - 1));
        k -= charValue;
    }
    return result.join('');
};