var getProbability = function(box1, box2) {
    const totalBalls = box1.length + box2.length;
    const countDistinct = (box) => new Set(box).size;
    const distinct1 = countDistinct(box1);
    const distinct2 = countDistinct(box2);

    if (distinct1 !== distinct2) return 0;

    const factorial = (n) => n <= 1 ? 1 : n * factorial(n - 1);

    const countWays = (box) => {
        const countMap = {};
        for (const ball of box) {
            countMap[ball] = (countMap[ball] || 0) + 1;
        }
        let ways = factorial(totalBalls);
        for (const count of Object.values(countMap)) {
            ways /= factorial(count);
        }
        return ways;
    };

    const ways1 = countWays(box1);
    const ways2 = countWays(box2);

    return ways1 / (ways1 + ways2);
};