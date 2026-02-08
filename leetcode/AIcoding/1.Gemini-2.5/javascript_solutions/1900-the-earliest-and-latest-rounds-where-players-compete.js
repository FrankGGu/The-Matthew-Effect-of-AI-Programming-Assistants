function earliestAndLatest(n, firstPlayer, secondPlayer) {
    const memo = new Map();

    // Adjust player numbers to be 0-indexed for easier array/bitmask handling
    const p1 = firstPlayer - 1;
    const p2 = secondPlayer - 1;

    // Ensure p1 is always the smaller index for canonical state representation
    const player1 = Math.min(p1, p2);
    const player2 = Math.max(p1, p2);

    function solve(num_active, fp_pos, sp_pos) {
        // Base case: If the two players are paired in this round, they compete.
        // In a round with `num_active` players, player at `k` (0-indexed) is paired with player at `num_active - 1 - k`.
        // If fp_pos + sp_pos === num_active - 1, they are paired.
        if (fp_pos + sp_pos === num_active - 1) {
            return [0, 0]; // 0 additional rounds needed from this point
        }

        const key = `${num_active}-${fp_pos}-${sp_pos}`;
        if (memo.has(key)) {
            return memo.get(key);
        }

        let min_rounds = Infinity;
        let max_rounds = -Infinity;

        const num_pairs = Math.floor(num_active / 2);
        const middle_player_advances = (num_active % 2 === 1);

        // Iterate through all possible combinations of winners for the current pairs.
        // There are `num_pairs` pairs, each can have 2 outcomes, so 2^num_pairs combinations.
        for (let i = 0; i < (1 << num_pairs); i++) {
            let next_fp_pos = -1;
            let next_sp_pos = -1;
            let next_num_active = 0; // Number of players in the next round
            let possible_combination = true;

            for (let j = 0; j < num_pairs; j++) {
                const p1_curr_pos = j; // Position of the first player in the current pair
                const p2_curr_pos = num_active - 1 - j; // Position of the second player in the current pair
                const chosen_winner_is_p1 = ((i >> j) & 1) === 0; // True if first player in pair wins (based on combination 'i')

                let winner_pos_for_next_round;

                // Determine if the chosen winner for this pair is valid based on `player1` and `player2` rules.
                if (p1_curr_pos === fp_pos) { // Player1 is the first player in this pair
                    if (!chosen_winner_is_p1) { // Player1 must win, but the combination 'i' chose the other player to win
                        possible_combination = false; break;
                    }
                    winner_pos_for_next_round = p1_curr_pos;
                } else if (p2_curr_pos === fp_pos) { // Player1 is the second player in this pair
                    if (chosen_winner_is_p1) { // Player1 must win, but the combination 'i' chose the other player to win
                        possible_combination = false; break;
                    }
                    winner_pos_for_next_round = p2_curr_pos;
                } else if (p1_curr_pos === sp_pos) { // Player2 is the first player in this pair
                    if (!chosen_winner_is_p1) { // Player2 must win, but the combination 'i' chose the other player to win
                        possible_combination = false; break;
                    }
                    winner_pos_for_next_round = p1_curr_pos;
                } else if (p2_curr_pos === sp_pos) { // Player2 is the second player in this pair
                    if (chosen_winner_is_p1) { // Player2 must win, but the combination 'i' chose the other player to win
                        possible_combination = false; break;
                    }
                    winner_pos_for_next_round = p2_curr_pos;
                } else { // Neither player1 nor player2 is in this pair, so either can win
                    winner_pos_for_next_round = chosen_winner_is_p1 ? p1_curr_pos : p2_curr_pos;
                }

                // If this specific pair's winner choice made the combination impossible, break and try next 'i'.
                if (!possible_combination) break;

                // Update the relative positions of player1 and player2 for the next round, and the count of active players.
                if (winner_pos_for_next_round === fp_pos) next_fp_pos = next_num_active;
                if (winner_pos_for_next_round === sp_pos) next_sp_pos = next_num_active;
                next_num_active++;
            }

            if (!possible_combination) {
                continue; // Skip this winner combination and try the next one
            }

            // If there's a middle player (odd number of players), they automatically advance.
            if (middle_player_advances) {
                const middle_player_curr_pos = num_pairs;
                if (middle_player_curr_pos === fp_pos) next_fp_pos = next_num_active;
                if (middle_player_curr_pos === sp_pos) next_sp_pos = next_num_active;
                next_num_active++;
            }

            // Recurse for the next round with the new state
            const [sub_min, sub_max] = solve(next_num_active, next_fp_pos, next_sp_pos);

            // Update min_rounds and max_rounds based on recursive results
            min_rounds = Math.min(min_rounds, 1 + sub_min);
            max_rounds = Math.max(max_rounds, 1 + sub_max);
        }

        const result = [min_rounds, max_rounds];
        memo.set(key, result);
        return result;
    }

    // Initial call to the recursive function.
    // The initial positions of player1 and player2 are just their 0-indexed values.
    const result = solve(n, player1, player2);

    // The problem asks for 1-indexed round numbers, so add 1 to the results.
    return [result[0] + 1, result[1] + 1];
}