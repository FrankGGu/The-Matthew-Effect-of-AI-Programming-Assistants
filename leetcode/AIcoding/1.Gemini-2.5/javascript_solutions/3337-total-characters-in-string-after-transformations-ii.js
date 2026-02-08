var totalCharactersInStringAfterTransformationsII = function(s, transformations, k) {
    const MOD = 10 ** 9 + 7;
    const MATRIX_SIZE = 26; // 'a' through 'z'

    // Step 1: Initialize initial_counts array from string s
    // initial_counts[i] stores the frequency of character 'a' + i
    const initial_counts = new Array(MATRIX_SIZE).fill(0);
    for (let i = 0; i < s.length; i++) {
        initial_counts[s.charCodeAt(i) - 'a'.charCodeAt(0)] = (initial_counts[s.charCodeAt(i) - 'a'.charCodeAt(0)] + 1) % MOD;
    }

    // Step 2: Preprocess transformations for quick lookup
    // mapping[c1_code] stores c2_code if there's a rule c1 -> c2
    // has_rule[c1_code] is true if c1 has a transformation rule
    const mapping = new Array(MATRIX_SIZE).fill(-1);
    const has_rule = new Array(MATRIX_SIZE).fill(false);
    for (const [c1_code, c2_code] of transformations) {
        mapping[c1_code] = c2_code;
        has_rule[c1_code] = true;
    }

    // Step 3: Build the transformation matrix T
    // T[i][j] represents how many times character 'j' is produced from one occurrence of character 'i'
    // The problem implies that the multiplier (count[c2]) uses the initial_counts (from string s).
    const T = Array(MATRIX_SIZE).fill(0).map(() => Array(MATRIX_SIZE).fill(0));

    for (let char_idx = 0; char_idx < MATRIX_SIZE; char_idx++) {
        if (has_rule[char_idx]) {
            const target_char_idx = mapping[char_idx];
            // One occurrence of char_idx is replaced by target_char_idx repeated initial_counts[target_char_idx] times.
            const multiplier = initial_counts[target_char_idx];
            T[char_idx][target_char_idx] = (T[char_idx][target_char_idx] + multiplier) % MOD;
        } else {
            // If no rule for char_idx, it remains itself (one char_idx produces one char_idx).
            T[char_idx][char_idx] = (T[char_idx][char_idx] + 1) % MOD;
        }
    }

    // Step 4: Matrix multiplication function
    const multiplyMatrices = (A, B) => {
        const C = Array(MATRIX_SIZE).fill(0).map(() => Array(MATRIX_SIZE).fill(0));
        for (let i = 0; i < MATRIX_SIZE; i++) {
            for (let j = 0; j < MATRIX_SIZE; j++) {
                for (let p = 0; p < MATRIX_SIZE; p++) {
                    C[i][j] = (C[i][j] + A[i][p] * B[p][j]) % MOD;
                }
            }
        }
        return C;
    };

    // Step 5: Matrix exponentiation function (computes M^exp)
    const matrixPower = (M, exp) => {
        // Initialize result as an identity matrix
        let result = Array(MATRIX_SIZE).fill(0).map((_, i) => Array(MATRIX_SIZE).fill(0).map((_, j) => (i === j ? 1 : 0)));
        let base = M;

        while (exp > 0) {
            if (exp % 2 === 1) { // If exp is odd, multiply result by current base
                result = multiplyMatrices(result, base);
            }
            base = multiplyMatrices(base, base); // Square the base
            exp = Math.floor(exp / 2); // Halve the exponent
        }
        return result;
    };

    // Step 6: Compute T^k
    const T_k = matrixPower(T, k);

    // Step 7: Compute final_counts_vector = initial_counts_vector * T_k
    // initial_counts is treated as a row vector.
    const final_counts = new Array(MATRIX_SIZE).fill(0);
    for (let j = 0; j < MATRIX_SIZE; j++) { // This loop iterates through columns of T_k (target characters)
        for (let p = 0; p < MATRIX_SIZE; p++) { // This loop iterates through rows of T_k (source characters)
            final_counts[j] = (final_counts[j] + initial_counts[p] * T_k[p][j]) % MOD;
        }
    }

    // Step 8: Sum elements of final_counts to get the total length
    let total_length = 0;
    for (let i = 0; i < MATRIX_SIZE; i++) {
        total_length = (total_length + final_counts[i]) % MOD;
    }

    return total_length;
};