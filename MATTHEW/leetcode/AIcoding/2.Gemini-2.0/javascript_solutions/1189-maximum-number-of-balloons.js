var maxNumberOfBalloons = function(text) {
    let count = {};
    for (let char of text) {
        count[char] = (count[char] || 0) + 1;
    }

    let balloonCount = 0;
    while (true) {
        if (count['b'] >= 1 && count['a'] >= 1 && count['l'] >= 2 && count['o'] >= 2 && count['n'] >= 1) {
            count['b']--;
            count['a']--;
            count['l'] -= 2;
            count['o'] -= 2;
            count['n']--;
            balloonCount++;
        } else {
            break;
        }
    }

    return balloonCount;
};