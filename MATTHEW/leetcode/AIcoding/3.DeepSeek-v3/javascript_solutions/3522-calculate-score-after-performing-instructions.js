var calculateScore = function(startPos, nums, s) {
    let score = 0;
    let pos = startPos;
    for (let i = 0; i < s.length; i++) {
        const direction = s[i];
        if (direction === 'L') {
            pos--;
        } else if (direction === 'R') {
            pos++;
        }
        if (pos < 0 || pos >= nums.length) {
            return -1;
        }
        score += nums[pos];
    }
    return score;
};