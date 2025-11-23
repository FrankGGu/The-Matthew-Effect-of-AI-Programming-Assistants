var maxHappyGroups = function(groups, groupSize) {
    let counts = new Array(groupSize).fill(0);
    for (let group of groups) {
        counts[group % groupSize]++;
    }

    let ans = counts[0];
    counts[0] = 0;

    let dp = new Map();

    function solve(state) {
        if (dp.has(state)) {
            return dp.get(state);
        }

        let key = Array.from(state.values()).join(',');

        let max = 0;
        for (let i = 1; i < groupSize; i++) {
            if (state.get(i) > 0) {
                let newState = new Map(state);
                newState.set(i, newState.get(i) - 1);

                let remainder = 0;
                for (let j = 1; j < groupSize; j++) {
                    remainder = (remainder + j * (state.get(j) || 0)) % groupSize;
                }

                let cur = (remainder - i + groupSize) % groupSize;

                max = Math.max(max, (cur === 0 ? 1 : 0) + solve(newState));
            }
        }

        dp.set(state, max);
        return max;
    }

    let initialState = new Map();
    for (let i = 1; i < groupSize; i++) {
        initialState.set(i, counts[i]);
    }

    return ans + solve(initialState);
};