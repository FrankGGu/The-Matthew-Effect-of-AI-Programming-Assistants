var bagOfTokensScore = function(tokens, power) {
    tokens.sort((a, b) => a - b);
    let score = 0;
    let left = 0;
    let right = tokens.length - 1;

    while (left <= right) {
        if (power >= tokens[left]) {
            power -= tokens[left];
            score++;
            left++;
        } else if (score > 0 && left < right) {
            power += tokens[right];
            score--;
            right--;
        } else {
            break;
        }
    }

    return score;
};