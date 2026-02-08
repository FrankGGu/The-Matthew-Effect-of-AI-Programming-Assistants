var countCompleteDayPairs = function(hours) {
    const modMap = new Map();
    let count = 0;

    for (const hour of hours) {
        const mod = hour % 24;
        const complement = (24 - mod) % 24;

        if (modMap.has(complement)) {
            count += modMap.get(complement);
        }

        modMap.set(mod, (modMap.get(mod) || 0) + 1);
    }

    return count;
};