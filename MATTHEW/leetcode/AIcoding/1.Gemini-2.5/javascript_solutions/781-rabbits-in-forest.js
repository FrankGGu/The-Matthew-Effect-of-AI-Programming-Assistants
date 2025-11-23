var numRabbits = function(answers) {
    if (answers.length === 0) {
        return 0;
    }

    const freqMap = new Map();
    for (const ans of answers) {
        freqMap.set(ans, (freqMap.get(ans) || 0) + 1);
    }

    let totalRabbits = 0;
    for (const [ans, count] of freqMap.entries()) {
        const groupSize = ans + 1;
        const numGroups = Math.ceil(count / groupSize);
        totalRabbits += numGroups * groupSize;
    }

    return totalRabbits;
};