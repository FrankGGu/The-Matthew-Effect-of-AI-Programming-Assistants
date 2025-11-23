var maxScore = function(s) {
    let max = 0;
    for (let i = 0; i < s.length - 1; i++) {
        let left = s.substring(0, i + 1);
        let right = s.substring(i + 1);
        let score = 0;
        for (let j = 0; j < left.length; j++) {
            if (left[j] === '0') {
                score++;
            }
        }
        for (let j = 0; j < right.length; j++) {
            if (right[j] === '1') {
                score++;
            }
        }
        max = Math.max(max, score);
    }
    return max;
};