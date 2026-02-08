var makesquare = function(matchsticks) {
    if (matchsticks === null || matchsticks.length === 0) {
        return false;
    }

    const totalSum = matchsticks.reduce((sum, len) => sum + len, 0);

    if (totalSum % 4 !== 0) {
        return false;
    }

    const target = totalSum / 4;

    matchsticks.sort((a, b) => b - a);

    if (matchsticks[0] > target) {
        return false;
    }

    const sides = new Array(4).fill(0);

    function backtrack(index) {
        if (index === matchsticks.length) {
            return true;
        }

        const currentMatchstick = matchsticks[index];

        for (let i = 0; i < 4; i++) {
            if (i > 0 && sides[i] === sides[i-1]) {
                continue;
            }

            if (sides[i] + currentMatchstick <= target) {
                sides[i] += currentMatchstick;
                if (backtrack(index + 1)) {
                    return true;
                }
                sides[i] -= currentMatchstick;
            }
        }

        return false;
    }

    return backtrack(0);
};