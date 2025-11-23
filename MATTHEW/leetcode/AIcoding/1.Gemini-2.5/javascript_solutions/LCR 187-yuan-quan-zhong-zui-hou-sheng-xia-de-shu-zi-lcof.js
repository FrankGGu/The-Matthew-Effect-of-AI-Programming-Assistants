var lastRemaining = function(n, m) {
    let result = 0; // Represents f(1, m), which is 0 (0-indexed)

    // Apply the Josephus recurrence relation: f(i, m) = (f(i-1, m) + m) % i
    // We iterate from i = 2 up to n
    for (let i = 2; i <= n; i++) {
        result = (result + m) % i;
    }

    return result;
};