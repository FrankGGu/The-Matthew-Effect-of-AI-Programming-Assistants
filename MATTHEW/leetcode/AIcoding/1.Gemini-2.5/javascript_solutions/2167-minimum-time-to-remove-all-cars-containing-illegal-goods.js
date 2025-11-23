var minimumTime = function(s) {
    const n = s.length;

    // P[k] stores the count of '1's in s[0...k-1]
    // P array will have size n+1, where P[0] = 0.
    // P[k+1] will store the count of '1's in s[0...k].
    const P = new Array(n + 1).fill(0);
    for (let k = 0; k < n; k++) {
        P[k + 1] = P[k] + (s[k] === '1' ? 1 : 0);
    }

    // The total cost for a chosen segment s[i...j] (inclusive) is:
    // (i) removals from the left (s[0...i-1])
    // + (n-1-j) removals from the right (s[j+1...n-1])
    // + 2 * (count of '1's in s[i...j])
    //
    // The count of '1's in s[i...j] is P[j+1] - P[i].
    // So, Cost = i + (n-1-j) + 2 * (P[j+1] - P[i])
    // Rearranging terms to separate i-dependent and j-dependent parts:
    // Cost = (n-1-j) + 2 * P[j+1] + (i - 2 * P[i])

    // Initialize minimum cost.
    // A base case is removing all '1's using operation 3 (cost 2 per '1').
    // This corresponds to choosing i=0 and j=n-1, meaning no cars are removed
    // from the ends. The cost would be 0 + 0 + 2 * (P[n] - P[0]) = 2 * P[n].
    let minCost = 2 * P[n];

    // min_prefix_term tracks the minimum value of (k - 2 * P[k]) for 0 <= k <= j.
    // When k=0, the term is 0 - 2 * P[0] = 0.
    let min_prefix_term = 0; 

    // We iterate 'j' from 0 to n-1. 'j' represents the rightmost index of the
    // "middle segment" s[i...j]. For each 'j', we want to find the best 'i' (0 <= i <= j)
    // that minimizes the total cost.
    for (let j = 0; j < n; j++) {
        // Update min_prefix_term for the current 'j'.
        // The term for i=j is j - 2 * P[j].
        min_prefix_term = Math.min(min_prefix_term, j - 2 * P[j]);

        // Calculate the current total cost for this 'j', using the best 'i' found so far
        // (which is represented by min_prefix_term).
        // The formula is: (n-1-j) + 2 * P[j+1] + min_prefix_term
        const currentTotalCost = (n - 1 - j) + 2 * P[j + 1] + min_prefix_term;
        minCost = Math.min(minCost, currentTotalCost);
    }

    return minCost;
};