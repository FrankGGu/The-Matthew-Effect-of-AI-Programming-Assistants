var minTime = function(tasks) {
    // Sort tasks by their end times. This greedy approach prioritizes tasks that must finish earlier.
    tasks.sort((a, b) => a[1] - b[1]);

    // A boolean array to keep track of occupied time units.
    // The maximum possible end time is 2000, so we need indices up to 2000.
    // An array of size 2001 (indices 0 to 2000) is sufficient.
    const maxPossibleTime = 2000;
    const occupied = new Array(maxPossibleTime + 1).fill(false);
    let totalTimeUnitsUsed = 0;

    for (const [start, end, duration] of tasks) {
        let currentCoveredDuration = 0;
        // Count how many units of this task's duration are already covered
        // by previously scheduled tasks within its [start, end] interval.
        for (let t = start; t <= end; t++) {
            if (occupied[t]) {
                currentCoveredDuration++;
            }
        }

        let neededDuration = duration - currentCoveredDuration;

        // If we still need to schedule more time for this task
        if (neededDuration > 0) {
            // To minimize the total time, it's optimal to schedule the remaining
            // duration as late as possible within the task's [start, end] interval.
            // This leaves earlier time slots free for subsequent tasks that might
            // have earlier start or end time constraints.
            for (let t = end; t >= start && neededDuration > 0; t--) {
                if (!occupied[t]) {
                    occupied[t] = true; // Mark this time unit as occupied
                    totalTimeUnitsUsed++; // Increment the total count of distinct time units used
                    neededDuration--; // Decrement the remaining duration needed for the current task
                }
            }
        }
    }

    return totalTimeUnitsUsed;
};