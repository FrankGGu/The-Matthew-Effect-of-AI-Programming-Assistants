const MOD = 10 ** 9 + 7;

const generateStates = (m) => {
    const states = [];

    const recurse = (row, current_state) => {
        if (row === m) {
            states.push([...current_state]);
            return;
        }

        for (let color = 0; color < 3; color++) {
            if (row > 0 && current_state[row - 1] === color) {
                continue;
            }
            current_state[row] = color;
            recurse(row + 1, current_state);
        }
    };

    recurse(0, new Array(m));
    return states;
};

const isCompatible = (state1, state2) => {
    for (let i = 0; i < state1.length; i++) {
        if (state1[i] === state2[i]) {
            return false;
        }
    }
    return true;
};

var paintGrid = function(m, n) {
    const valid_states = generateStates(m);
    const num_states = valid_states.length;

    const adj = Array.from({ length: num_states }, () => []);
    for (let i = 0; i < num_states; i++) {
        for (let j = 0; j < num_states; j++) {
            if (isCompatible(valid_states[i], valid_states[j])) {
                adj[j].push(i);
            }
        }
    }

    let dp = new Array(num_states).fill(1);

    for (let col = 1; col < n; col++) {
        let next_dp = new Array(num_states).fill(0);
        for (let current_state_idx = 0; current_state_idx < num_states; current_state_idx++) {
            for (const prev_state_idx of adj[current_state_idx]) {
                next_dp[current_state_idx] = (next_dp[current_state_idx] + dp[prev_state_idx]) % MOD;
            }
        }
        dp = next_dp;
    }

    let total_ways = 0;
    for (let i = 0; i < num_states; i++) {
        total_ways = (total_ways + dp[i]) % MOD;
    }

    return total_ways;
};