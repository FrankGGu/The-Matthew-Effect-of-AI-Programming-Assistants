var possiblyEquals = function(s1, s2) {
    const n1 = s1.length;
    const n2 = s2.length;
    const MAX_LEN = Math.max(n1, n2); 
    const OFFSET = MAX_LEN; // To map diff from [-MAX_LEN, MAX_LEN] to [0, 2*MAX_LEN]

    // memo[i][j][diff + OFFSET]
    // Initialize with null to distinguish uncomputed from false
    const memo = new Array(n1 + 1).fill(0).map(() =>
        new Array(n2 + 1).fill(0).map(() =>
            new Array(2 * MAX_LEN + 1).fill(null)
        )
    );

    function isDigit(char) {
        return char >= '0' && char <= '9';
    }

    // Helper function to parse all possible number interpretations from string s starting at index idx.
    // For "123", it returns [ [1, 1], [12, 2] ] if MAX_LEN is 40 (since 123 > 40).
    // Each element is [numerical_value, next_index_after_number].
    function parseNumbers(s, idx) {
        const numbers = [];
        let currentNum = 0;
        let k = idx;

        while (k < s.length && isDigit(s[k])) {
            currentNum = currentNum * 10 + parseInt(s[k]);

            // If the number exceeds the maximum possible length, it cannot be a single number.
            // For example, if max length is 40, "123" cannot be interpreted as 123 characters.
            // It must be interpreted as 1, or 12.
            if (currentNum > MAX_LEN) {
                break;
            }
            numbers.push([currentNum, k + 1]);
            k++;
        }
        return numbers;
    }

    function dfs(i, j, diff) {
        // Base case: Both strings exhausted
        if (i === n1 && j === n2) {
            return diff === 0;
        }

        // Check memoization
        if (memo[i][j][diff + OFFSET] !== null) {
            return memo[i][j][diff + OFFSET];
        }

        let result = false;

        // Case 1: diff > 0 (s1 is ahead by 'diff' characters, s2 needs to catch up)
        if (diff > 0) {
            // s2 must advance
            if (j < n2) { // Ensure s2 is not exhausted
                if (isDigit(s2[j])) {
                    const parsedNums = parseNumbers(s2, j);
                    for (const [num, next_j] of parsedNums) {
                        if (dfs(i, next_j, diff - num)) {
                            result = true;
                            break;
                        }
                    }
                } else {
                    // s2 consumes one character. diff decreases by 1.
                    result = dfs(i, j + 1, diff - 1);
                }
            }
        }
        // Case 2: diff < 0 (s2 is ahead by 'abs(diff)' characters, s1 needs to catch up)
        else if (diff < 0) {
            // s1 must advance
            if (i < n1) { // Ensure s1 is not exhausted
                if (isDigit(s1[i])) {
                    const parsedNums = parseNumbers(s1, i);
                    for (const [num, next_i] of parsedNums) {
                        if (dfs(next_i, j, diff + num)) {
                            result = true;
                            break;
                        }
                    }
                } else {
                    // s1 consumes one character. diff increases by 1.
                    result = dfs(i + 1, j, diff + 1);
                }
            }
        }
        // Case 3: diff == 0 (Both are aligned)
        else { // diff === 0
            // Option 1: s1 advances
            if (i < n1) {
                if (isDigit(s1[i])) {
                    const parsedNums = parseNumbers(s1, i);
                    for (const [num, next_i] of parsedNums) {
                        if (dfs(next_i, j, -num)) { // s1 skips 'num' characters. s2 is now 'num' characters ahead.
                            result = true;
                            break;
                        }
                    }
                } else {
                    // s1 consumes one character. s1 is now 1 character ahead.
                    if (dfs(i + 1, j, 1)) {
                        result = true;
                    }
                }
            }

            // If result is already true, no need to explore further for this state
            if (result) {
                memo[i][j][diff + OFFSET] = result;
                return result;
            }

            // Option 2: s2 advances
            if (j < n2) {
                if (isDigit(s2[j])) {
                    const parsedNums = parseNumbers(s2, j);
                    for (const [num, next_j] of parsedNums) {
                        if (dfs(i, next_j, num)) { // s2 skips 'num' characters. s1 is now 'num' characters ahead.
                            result = true;
                            break;
                        }
                    }
                } else {
                    // s2 consumes one character. s2 is now 1 character ahead.
                    if (dfs(i, j + 1, -1)) {
                        result = true;
                    }
                }
            }

            // If result is already true, no need to explore further for this state
            if (result) {
                memo[i][j][diff + OFFSET] = result;
                return result;
            }

            // Option 3: Both s1 and s2 are letters and match
            if (i < n1 && j < n2 && !isDigit(s1[i]) && !isDigit(s2[j])) {
                if (s1[i] === s2[j]) {
                    if (dfs(i + 1, j + 1, 0)) {
                        result = true;
                    }
                }
            }
        }

        // Store and return result
        memo[i][j][diff + OFFSET] = result;
        return result;
    }

    return dfs(0, 0, 0);
};