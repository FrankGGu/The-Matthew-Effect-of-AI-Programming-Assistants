var minimumOperationsToMakeEqual = function(x, y) {
    if (x === y) {
        return 0;
    }

    const queue = [[x, 0]]; // [current_value, operations]
    const visited = new Set();
    visited.add(x);

    // A reasonable upper bound for states to explore.
    // We might need to increment x by up to 10 to make it divisible by 11,
    // or up to 4 to make it divisible by 5.
    // So, Math.max(x, y) + 11 covers cases where we go slightly above y or x
    // to find a division opportunity.
    const MAX_STATE_VALUE = Math.max(x, y) + 11; 

    while (queue.length > 0) {
        const [curr, ops] = queue.shift();

        // Define possible next states and their operations
        const possibleNextStates = [];

        // Operation: curr - 1
        possibleNextStates.push([curr - 1, ops + 1]);

        // Operation: curr + 1
        possibleNextStates.push([curr + 1, ops + 1]);

        // Operation: curr / 5 (if divisible)
        if (curr % 5 === 0) {
            possibleNextStates.push([curr / 5, ops + 1]);
        }

        // Operation: curr / 11 (if divisible)
        if (curr % 11 === 0) {
            possibleNextStates.push([curr / 11, ops + 1]);
        }

        for (const [nextVal, nextOps] of possibleNextStates) {
            if (nextVal === y) {
                return nextOps;
            }

            // Ensure nextVal is within reasonable bounds and has not been visited
            // Values must be positive (>= 1) as per problem constraints on x, y.
            // Limiting the upper bound prevents exploring unnecessarily large numbers.
            if (nextVal >= 1 && nextVal <= MAX_STATE_VALUE && !visited.has(nextVal)) {
                visited.add(nextVal);
                queue.push([nextVal, nextOps]);
            }
        }
    }

    // This part should theoretically not be reached if a path always exists.
    // Given the operations (+1, -1, /5, /11), it's always possible to reach Y from X.
    return -1; 
};