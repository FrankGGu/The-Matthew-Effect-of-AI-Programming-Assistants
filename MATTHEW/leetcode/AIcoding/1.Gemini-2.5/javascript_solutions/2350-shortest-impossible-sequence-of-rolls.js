var shortestSequence = function(rolls, k) {
    let currentNumToFind = 1;
    let foundNumbersInCurrentCycle = new Set();

    for (let i = 0; i < rolls.length; i++) {
        const roll = rolls[i];
        if (roll >= 1 && roll <= k) {
            foundNumbersInCurrentCycle.add(roll);
            if (foundNumbersInCurrentCycle.size === k) {
                // We have found all numbers from 1 to k in the current segment of rolls.
                // This means we can form the sequence [1, 2, ..., k] (or rather,
                // we've completed one 'layer' of finding 1 through k).

                // We increment currentNumToFind because we've successfully found
                // all numbers up to the current 'layer' count.
                currentNumToFind++;
                // Clear the set to start looking for the next set of numbers (1 to k)
                // for the next 'layer' of the sequence.
                foundNumbersInCurrentCycle.clear();
            }
        }
    }

    // The result is currentNumToFind.
    // If currentNumToFind is X, it means we were able to fully form
    // X-1 complete sets of [1, ..., k] (or partial sets that eventually
    // built up to X-1 'layers' of the sequence).
    // The sequence [1, 2, ..., currentNumToFind] is the shortest impossible sequence.
    return currentNumToFind;
};