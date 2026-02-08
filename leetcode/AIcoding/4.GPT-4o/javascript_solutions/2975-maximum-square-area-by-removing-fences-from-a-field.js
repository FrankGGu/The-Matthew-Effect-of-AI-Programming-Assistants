function maxSquareArea(length, width, fence) {
    const totalArea = length * width;
    let maxArea = 0;

    for (let i = 1; i <= length; i++) {
        for (let j = 1; j <= width; j++) {
            if (i * j <= totalArea - fence) {
                maxArea = Math.max(maxArea, Math.min(i, j) * Math.min(i, j));
            }
        }
    }
    return maxArea;
}