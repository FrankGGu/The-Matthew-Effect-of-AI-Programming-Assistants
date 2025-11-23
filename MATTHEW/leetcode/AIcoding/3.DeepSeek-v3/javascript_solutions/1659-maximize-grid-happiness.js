var getMaxGridHappiness = function(m, n, introvertsCount, extrovertsCount) {
    const memo = {};
    const maxState = Math.pow(3, n);
    const ternary = Array(n).fill(0);

    function calculate(pos, prevState, inCount, exCount) {
        if (pos === m * n || (inCount === 0 && exCount === 0)) {
            return 0;
        }
        const key = `${pos},${prevState},${inCount},${exCount}`;
        if (memo[key] !== undefined) {
            return memo[key];
        }

        let res = 0;
        const x = Math.floor(pos / n);
        const y = pos % n;

        let up = 0;
        if (x > 0) {
            up = Math.floor(prevState / Math.pow(3, n - 1));
        }
        let left = 0;
        if (y > 0) {
            left = prevState % 3;
        }

        const newState = (prevState * 3) % maxState;

        // Place nothing
        res = calculate(pos + 1, newState, inCount, exCount);

        // Place introvert
        if (inCount > 0) {
            let total = 120;
            if (up === 1) {
                total -= 30;
                total -= 30;
            } else if (up === 2) {
                total -= 30;
                total += 20;
            }
            if (left === 1) {
                total -= 30;
                total -= 30;
            } else if (left === 2) {
                total -= 30;
                total += 20;
            }
            const nextState = newState + 1;
            res = Math.max(res, total + calculate(pos + 1, nextState, inCount - 1, exCount));
        }

        // Place extrovert
        if (exCount > 0) {
            let total = 40;
            if (up === 1) {
                total += 20;
                total -= 30;
            } else if (up === 2) {
                total += 20;
                total += 20;
            }
            if (left === 1) {
                total += 20;
                total -= 30;
            } else if (left === 2) {
                total += 20;
                total += 20;
            }
            const nextState = newState + 2;
            res = Math.max(res, total + calculate(pos + 1, nextState, inCount, exCount - 1));
        }

        memo[key] = res;
        return res;
    }

    return calculate(0, 0, introvertsCount, extrovertsCount);
};