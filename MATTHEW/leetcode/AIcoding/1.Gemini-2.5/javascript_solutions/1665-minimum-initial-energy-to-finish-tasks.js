var minimumEffort = function(tasks) {
    // Sort tasks in descending order of (minimum_required - actual_cost).
    // This prioritizes tasks that have a larger difference between their minimum required energy
    // and their actual energy cost. Essentially, tasks that are "cheaper" relative to their
    // minimum requirement are done first, leaving more energy for subsequent tasks.
    tasks.sort((a, b) => (b[1] - b[0]) - (a[1] - a[0]));

    let currentEnergy = 0; // Represents the energy we have after completing tasks, relative to the initial energy.
                           // Can go negative if we've spent more than we currently have.
    let initialEnergyNeeded = 0; // The total initial energy we must start with.

    for (const [actual, minimum] of tasks) {
        // If our current energy is less than the minimum required for the current task,
        // we must increase our initial energy to meet this requirement.
        if (currentEnergy < minimum) {
            // The amount we need to add to our initial energy is the difference
            // between the minimum required and our current energy.
            initialEnergyNeeded += (minimum - currentEnergy);
            // After adding this amount, our current energy effectively becomes 'minimum'
            // because we now have enough initial energy to reach that point.
            currentEnergy = minimum;
        }
        // After ensuring we have enough energy (either from existing or added initial energy),
        // complete the task by subtracting its actual cost.
        currentEnergy -= actual;
    }

    return initialEnergyNeeded;
};