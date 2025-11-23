var minimumOperations = function(nums, start, target) {
    const queue = [[start, 0]]; // [current_number, operations_count]
    const visited = new Set();
    visited.add(start);

    while (queue.length > 0) {
        const [currentNum, operations] = queue.shift();

        // If currentNum is the target, we found the shortest path
        if (currentNum === target) {
            return operations;
        }

        for (const x of nums) {
            const nextStates = [
                currentNum + x,
                currentNum - x,
                currentNum ^ x
            ];

            for (const nextNum of nextStates) {
                // If any of the next operations directly hit the target, return immediately
                if (nextNum === target) {
                    return operations + 1;
                }

                // The problem states that numbers can become negative or greater than 1000.
                // To prevent infinite loops and manage memory in an unbounded state space,
                // we typically limit the range of numbers we add to the queue/visited set.
                // Given target and nums[i] are up to 1000, a common heuristic is to
                // consider numbers within a range like [-1000, 2000] or [-2000, 3000].
                // This range covers initial operations and a few steps beyond the target/start values.
                // Numbers outside this range are unlikely to be part of an optimal path.
                // Using [-1000, 2000] as a bound:
                // Max possible value for `start` + `nums[i]` is `1000 + 1000 = 2000`.
                // Min possible value for `start` - `nums[i]` is `0 - 1000 = -1000`.
                // Max possible XOR value for two numbers up to 1000 is `1023 ^ 511 = 1534`.
                // This range seems sufficient for the problem constraints.
                if (!visited.has(nextNum) && nextNum >= -1000 && nextNum <= 2000) {
                    visited.add(nextNum);
                    queue.push([nextNum, operations + 1]);
                }
            }
        }
    }

    // If the queue becomes empty and target was not reached, it's impossible.
    return -1;
};