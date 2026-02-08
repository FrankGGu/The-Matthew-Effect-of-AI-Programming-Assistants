function maximumGain(s, x, y) {
    let totalScore = 0;

    function removeAndScore(str, pair, score) {
        let currentScore = 0;
        let stack = [];
        for (let char of str) {
            if (stack.length > 0 && stack[stack.length - 1] === pair[0] && char === pair[1]) {
                stack.pop();
                currentScore += score;
            } else {
                stack.push(char);
            }
        }
        return [currentScore, stack.join('')];
    }

    let remainingString;
    let currentPassScore;

    if (x >= y) {
        [currentPassScore, remainingString] = removeAndScore(s, 'ab', x);
        totalScore += currentPassScore;
        [currentPassScore, remainingString] = removeAndScore(remainingString, 'ba', y);
        totalScore += currentPassScore;
    } else {
        [currentPassScore, remainingString] = removeAndScore(s, 'ba', y);
        totalScore += currentPassScore;
        [currentPassScore, remainingString] = removeAndScore(remainingString, 'ab', x);
        totalScore += currentPassScore;
    }

    return totalScore;
}