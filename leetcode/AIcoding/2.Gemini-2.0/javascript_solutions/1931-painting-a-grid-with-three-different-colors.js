var colorTheGrid = function(m, n) {
    const MOD = 1000000007;
    const validStates = [];
    const adj = new Map();

    function isValid(state, m) {
        for (let i = 0; i < m - 1; i++) {
            if ((state & (3 << (2 * i))) === (state & (3 << (2 * (i + 1))))) {
                return false;
            }
        }
        return true;
    }

    function generateStates(m) {
        for (let i = 0; i < (3 ** m); i++) {
            let state = 0;
            let temp = i;
            for (let j = 0; j < m; j++) {
                state |= ((temp % 3) << (2 * j));
                temp = Math.floor(temp / 3);
            }
            if (isValid(state, m)) {
                validStates.push(state);
            }
        }
    }

    function areAdjacent(state1, state2, m) {
        for (let i = 0; i < m; i++) {
            if ((state1 & (3 << (2 * i))) === (state2 & (3 << (2 * i)))) {
                return false;
            }
        }
        return true;
    }

    generateStates(m);

    for (const state1 of validStates) {
        adj.set(state1, []);
        for (const state2 of validStates) {
            if (areAdjacent(state1, state2, m)) {
                adj.get(state1).push(state2);
            }
        }
    }

    let dp = new Map();
    for (const state of validStates) {
        dp.set(state, 1);
    }

    for (let i = 1; i < n; i++) {
        const newDp = new Map();
        for (const state of validStates) {
            newDp.set(state, 0);
        }

        for (const state1 of validStates) {
            for (const state2 of adj.get(state1)) {
                newDp.set(state2, (newDp.get(state2) + dp.get(state1)) % MOD);
            }
        }

        dp = newDp;
    }

    let total = 0;
    for (const state of validStates) {
        total = (total + dp.get(state)) % MOD;
    }

    return total;
};