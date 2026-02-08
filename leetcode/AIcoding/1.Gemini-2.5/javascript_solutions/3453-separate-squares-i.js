var separateSquares = function(nums) {
    const perfectSquares = [];
    const nonPerfectSquares = [];

    for (const num of nums) {
        if (num < 0) {
            nonPerfectSquares.push(num);
            continue;
        }
        const sqrt = Math.sqrt(num);
        if (sqrt % 1 === 0) {
            perfectSquares.push(num);
        } else {
            nonPerfectSquares.push(num);
        }
    }

    return [perfectSquares, nonPerfectSquares];
};