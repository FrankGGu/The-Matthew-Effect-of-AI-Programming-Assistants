var makesquare = function(matchsticks) {
    if (!matchsticks || matchsticks.length < 4) return false;
    let sum = matchsticks.reduce((a, b) => a + b, 0);
    if (sum % 4 !== 0) return false;
    let side = sum / 4;
    matchsticks.sort((a, b) => b - a);

    function dfs(index, sides) {
        if (index === matchsticks.length) {
            return sides.every(s => s === side);
        }

        for (let i = 0; i < 4; i++) {
            if (sides[i] + matchsticks[index] <= side) {
                sides[i] += matchsticks[index];
                if (dfs(index + 1, sides)) {
                    return true;
                }
                sides[i] -= matchsticks[index];
            }
            if (sides[i] === 0) break;
        }
        return false;
    }

    return dfs(0, [0, 0, 0, 0]);
};