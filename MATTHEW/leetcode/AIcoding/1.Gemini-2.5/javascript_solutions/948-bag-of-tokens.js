var bagOfTokens = function(tokens, power) {
    tokens.sort((a, b) => a - b);

    let left = 0;
    let right = tokens.length - 1;
    let score = 0;
    let maxScore = 0;

    while (left <= right) {
        if (power >= tokens[left]) {
            power -= tokens[left];
            score++;
            left++;
            maxScore = Math.max(maxScore, score);
        } else if (score >= 1 && left < right) {
            power += tokens[right];
            score--;
            right--;
        } else {
            break;
        }
    }

    return maxScore;
};