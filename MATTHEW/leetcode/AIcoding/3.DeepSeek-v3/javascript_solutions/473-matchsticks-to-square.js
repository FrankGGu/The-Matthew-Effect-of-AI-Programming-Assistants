var makesquare = function(matchsticks) {
    if (matchsticks.length < 4) return false;

    const total = matchsticks.reduce((sum, val) => sum + val, 0);
    if (total % 4 !== 0) return false;

    const side = total / 4;
    matchsticks.sort((a, b) => b - a);

    const sides = new Array(4).fill(0);

    const backtrack = (index) => {
        if (index === matchsticks.length) {
            return sides.every(s => s === side);
        }

        for (let i = 0; i < 4; i++) {
            if (sides[i] + matchsticks[index] <= side) {
                sides[i] += matchsticks[index];
                if (backtrack(index + 1)) {
                    return true;
                }
                sides[i] -= matchsticks[index];
            }
        }
        return false;
    };

    return backtrack(0);
};