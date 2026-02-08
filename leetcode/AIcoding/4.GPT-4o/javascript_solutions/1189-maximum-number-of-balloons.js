var maxNumberOfBalloons = function(text) {
    const count = {};
    for (const char of text) {
        count[char] = (count[char] || 0) + 1;
    }
    return Math.min(
        Math.floor((count['b'] || 0) / 1),
        Math.floor((count['a'] || 0) / 1),
        Math.floor((count['l'] || 0) / 2),
        Math.floor((count['o'] || 0) / 2),
        Math.floor((count['n'] || 0) / 1)
    );
};