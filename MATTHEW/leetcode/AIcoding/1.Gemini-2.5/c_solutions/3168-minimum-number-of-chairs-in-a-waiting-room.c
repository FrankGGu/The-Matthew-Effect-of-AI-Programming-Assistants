int minChairs(int* arrival, int arrivalSize, int* duration, int durationSize) {
    int maxChairs = 0;
    int currentChairs = 0;

    // Create a timeline of events (arrival and departure)
    // Each event is a pair: {time, type}
    // type = 1 for arrival, -1 for departure
    // The size of events array will be 2 * arrivalSize
    // We need to dynamically allocate or use a fixed size large enough
    // For LeetCode constraints, arrivalSize <= 1000, so 2000 events max.
    // A struct or a 2D array can be used. Let's use a 2D array for simplicity.
    int events[2 * arrivalSize][2];
    int eventCount = 0;

    for (int i = 0; i < arrivalSize; i++) {
        events[eventCount][0] = arrival[i];
        events[eventCount][1] = 1; // Arrival
        eventCount++;

        events[eventCount][0] = arrival[i] + duration[i];
        events[eventCount][1] = -1; // Departure
        eventCount++;
    }

    // Sort the events.
    // Primary sort key: time
    // Secondary sort key: type (departures first if times are equal, to free up chairs for new arrivals)
    // This is crucial: if a departure and arrival happen at the same time,
    // we want to process the departure first to potentially reuse a chair.
    // So, type -1 comes before type 1.
    for (int i = 0; i < eventCount - 1; i++) {
        for (int j = i + 1; j < eventCount; j++) {
            if (events[i][0] > events[j][0] ||
                (events[i][0] == events[j][0] && events[i][1] > events[j][1])) {
                // Swap
                int tempTime = events[i][0];
                int tempType = events[i][1];

                events[i][0] = events[j][0];
                events[i][1] = events[j][1];

                events[j][0] = tempTime;
                events[j][1] = tempType;
            }
        }
    }

    // Process sorted events
    for (int i = 0; i < eventCount; i++) {
        currentChairs += events[i][1]; // Add 1 for arrival, subtract 1 for departure
        if (currentChairs > maxChairs) {
            maxChairs = currentChairs;
        }
    }

    return maxChairs;
}