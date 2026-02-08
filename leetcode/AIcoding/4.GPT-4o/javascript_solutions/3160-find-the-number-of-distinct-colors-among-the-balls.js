function countBalls(lowLimit, highLimit) {
    const colorCount = new Map();
    for (let i = lowLimit; i <= highLimit; i++) {
        const sum = String(i).split('').reduce((a, b) => a + Number(b), 0);
        colorCount.set(sum, (colorCount.get(sum) || 0) + 1);
    }
    return colorCount.size;
}