var makesquare = function(matchsticks) {
    const totalLength = matchsticks.reduce((a, b) => a + b, 0);
    if (totalLength % 4 !== 0) return false;
    const sideLength = totalLength / 4;
    const sides = new Array(4).fill(0);

    matchsticks.sort((a, b) => b - a);

    const dfs = (index) => {
        if (index === matchsticks.length) {
            return sides[0] === sides[1] && sides[1] === sides[2] && sides[2] === sides[3];
        }
        for (let i = 0; i < 4; i++) {
            if (sides[i] + matchsticks[index] <= sideLength) {
                sides[i] += matchsticks[index];
                if (dfs(index + 1)) return true;
                sides[i] -= matchsticks[index];
            }
        }
        return false;
    };

    return dfs(0);
};