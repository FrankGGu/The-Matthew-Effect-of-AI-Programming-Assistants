var findTheString = function(lcp) {
    const n = lcp.length;

    // DSU structure
    const parent = new Array(n).fill(0).map((_, i) => i);

    const find = (i) => {
        if (parent[i] === i) {
            return i;
        }
        return parent[i] = find(parent[i]);
    };

    const union = (i, j) => {
        const root_i = find(i);
        const root_j = find(j);
        if (root_i !== root_j) {
            parent[root_i] = root_j;
        }
    };

    // Step 1: Initial LCP matrix validation (basic properties and consistency)
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            // Basic range and symmetry checks
            // lcp[i][j] must be non-negative and not exceed the length of either suffix
            if (lcp[i][j] < 0 || lcp[i][j] > n - Math.max(i, j)) {
                return "";
            }
            // LCP matrix must be symmetric
            if (lcp[i][j] !== lcp[j][i]) {
                return "";
            }
            // Diagonal elements lcp[i][i] must be the length of the suffix s[i...]
            if (i === j && lcp[i][j] !== n - i) {
                return "";
            }

            // Consistency with next characters:
            // If lcp[i][j] > 0, it means s[i] == s[j].
            // It also implies that the LCP of the next characters (s[i+1...] and s[j+1...])
            // must be exactly lcp[i][j] - 1.
            if (lcp[i][j] > 0) {
                if (i + 1 >= n || j + 1 >= n || lcp[i+1][j+1] !== lcp[i][j] - 1) {
                    return "";
                }
            }
        }
    }

    // Step 2: DSU construction based on character equality constraints
    // If lcp[i][j] > 0, then s[i+k] must be equal to s[j+k] for k from 0 to lcp[i][j]-1.
    // We use DSU to group indices that must have the same character.
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (lcp[i][j] > 0) {
                for (let k = 0; k < lcp[i][j]; k++) {
                    union(i + k, j + k);
                }
            }
        }
    }

    // Step 3: Assign characters to DSU roots
    // Iterate through each position, assign characters greedily starting from 'a'.
    // All positions belonging to the same DSU root get the same character.
    const ans = new Array(n);
    const charMap = new Map(); // Maps DSU root to an assigned character
    let nextCharCode = 'a'.charCodeAt(0);

    for (let i = 0; i < n; i++) {
        const root_i = find(i);
        if (!charMap.has(root_i)) {
            // If we run out of lowercase English letters, it's impossible.
            if (nextCharCode > 'z'.charCodeAt(0)) {
                return "";
            }
            charMap.set(root_i, String.fromCharCode(nextCharCode));
            nextCharCode++;
        }
        ans[i] = charMap.get(root_i);
    }

    const s_candidate = ans.join('');

    // Step 4: Final LCP matrix validation (compare derived string's LCP with the given LCP)
    // Calculate the LCP matrix for the constructed string and ensure it matches the input.
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            let actualLcpVal = 0;
            while (i + actualLcpVal < n && 
                   j + actualLcpVal < n && 
                   s_candidate[i + actualLcpVal] === s_candidate[j + actualLcpVal]) {
                actualLcpVal++;
            }
            if (actualLcpVal !== lcp[i][j]) {
                return ""; // Mismatch found, string is invalid
            }
        }
    }

    // Step 5: If all validations pass, return the constructed string
    return s_candidate;
};