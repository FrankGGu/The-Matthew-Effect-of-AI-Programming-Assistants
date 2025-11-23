var scoreOfStudents = function(expression, answers) {
    let nums = [];
    let ops = [];

    // Parse expression into numbers and operators
    for (let i = 0; i < expression.length; i++) {
        const char = expression[i];
        if (char >= '0' && char <= '9') {
            nums.push(parseInt(char));
        } else {
            ops.push(char);
        }
    }

    const M = nums.length; // Number of digits

    // --- Calculate all possible values (ignoring precedence) using DP ---
    // dp[i][j] stores a Set of all possible results for subexpression nums[i]...nums[j]
    let dp = Array(M).fill(0).map(() => Array(M).fill(null));

    // Base case: a single number has only itself as a possible value
    for (let i = 0; i < M; i++) {
        dp[i][i] = new Set([nums[i]]);
    }

    // Fill DP table for subexpressions of increasing length
    for (let len = 2; len <= M; len++) {
        for (let i = 0; i <= M - len; i++) {
            let j = i + len - 1;
            dp[i][j] = new Set();

            // Iterate over all possible split points 'k'
            // k represents the index of the operator in the 'ops' array
            // The subexpression is split into nums[i]...nums[k] and nums[k+1]...nums[j]
            // The operator applied is ops[k]
            for (let k = i; k < j; k++) {
                const operator = ops[k];
                for (const val1 of dp[i][k]) {
                    for (const val2 of dp[k + 1][j]) {
                        let res;
                        if (operator === '+') {
                            res = val1 + val2;
                        } else { // operator === '*'
                            res = val1 * val2;
                        }
                        // Only add results that are <= 1000
                        if (res <= 1000) {
                            dp[i][j].add(res);
                        }
                    }
                }
            }
        }
    }

    const possibleValues = dp[0][M - 1];

    // --- Calculate the actual correct value (respecting precedence) ---
    let actualValue = 0;
    let productStack = []; // Used to handle multiplication precedence
    let currentOp = '+';   // The operator that applies to the next number

    for (let i = 0; i < M; i++) {
        let num = nums[i];
        if (currentOp === '+') {
            productStack.push(num);
        } else if (currentOp === '*') {
            // Apply multiplication immediately
            productStack.push(productStack.pop() * num);
        }

        // Update currentOp for the next number
        if (i < M - 1) {
            currentOp = ops[i];
        }
    }

    // Sum up all elements in productStack (these are numbers or products already computed)
    for (const val of productStack) {
        actualValue += val;
    }

    // --- Score the students ---
    let score = 0;
    for (const ans of answers) {
        if (ans === actualValue) {
            score += 5;
        } else if (possibleValues.has(ans)) {
            score += 2;
        }
    }

    return score;
};