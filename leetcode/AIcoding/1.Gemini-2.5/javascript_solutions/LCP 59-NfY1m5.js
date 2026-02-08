var minTime = function(times) {
    times.sort((a, b) => a - b);

    const n = times.length;

    if (n === 0) {
        return 0;
    }
    if (n === 1) {
        return times[0];
    }
    if (n === 2) {
        return times[1];
    }
    if (n === 3) {
        return times[0] + times[1] + times[2];
    }

    let totalTime = 0;
    let left = n;

    while (left > 3) {
        // Strategy 1: Fastest person (times[0]) shuttles the two slowest (times[left-1], times[left-2])
        // Sequence:
        // 1. times[0] and times[left-1] cross (cost: times[left-1])
        // 2. times[0] returns (cost: times[0])
        // 3. times[0] and times[left-2] cross (cost: times[left-2])
        // 4. times[0] returns (cost: times[0])
        // Total cost for this cycle: times[left-1] + times[0] + times[left-2] + times[0]
        const strategy1 = times[left - 1] + times[left - 2] + 2 * times[0];

        // Strategy 2: Two fastest people (times[0], times[1]) help the two slowest (times[left-1], times[left-2])
        // Sequence:
        // 1. times[0] and times[1] cross (cost: times[1])
        // 2. times[0] returns (cost: times[0])
        // 3. times[left-1] and times[left-2] cross (cost: times[left-1])
        // 4. times[1] returns (cost: times[1])
        // Total cost for this cycle: times[1] + times[0] + times[left-1] + times[1]
        const strategy2 = times[1] + times[0] + times[left - 1] + times[1];

        totalTime += Math.min(strategy1, strategy2);
        left -= 2;
    }

    if (left === 1) {
        totalTime += times[0];
    } else if (left === 2) {
        totalTime += times[1];
    } else if (left === 3) {
        totalTime += times[0] + times[1] + times[2];
    }

    return totalTime;
};