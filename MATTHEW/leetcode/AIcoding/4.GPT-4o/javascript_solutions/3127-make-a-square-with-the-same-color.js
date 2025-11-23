function makesquare(matchsticks) {
    const totalLength = matchsticks.reduce((a, b) => a + b, 0);
    if (totalLength % 4 !== 0) return false;
    const sideLength = totalLength / 4;
    const sides = new Array(4).fill(0);

    function backtrack(index) {
        if (index === matchsticks.length) {
            return sides.every(side => side === sideLength);
        }
        for (let i = 0; i < 4; i++) {
            if (sides[i] + matchsticks[index] <= sideLength) {
                sides[i] += matchsticks[index];
                if (backtrack(index + 1)) return true;
                sides[i] -= matchsticks[index];
            }
            if (sides[i] === 0) break; // Optimization
        }
        return false;
    }

    return backtrack(0);
}