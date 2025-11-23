var countGoodRectangles = function(rectangles) {
    let maxLen = 0;
    let count = 0;
    for (let i = 0; i < rectangles.length; i++) {
        let len = Math.min(rectangles[i][0], rectangles[i][1]);
        if (len > maxLen) {
            maxLen = len;
            count = 1;
        } else if (len === maxLen) {
            count++;
        }
    }
    return count;
};