#include <stdlib.h> // For qsort

int compareInt(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int latestTimeCatchTheBus(int* buses, int busesSize, int* passengers, int passengersSize, int capacity) {
    // Sort bus departure times and passenger arrival times in ascending order
    qsort(buses, busesSize, sizeof(int), compareInt);
    qsort(passengers, passengersSize, sizeof(int), compareInt);

    int passenger_ptr = 0; // Pointer to the next passenger to consider from the sorted passengers array
    int last_passenger_boarded_time = 0; // Stores the arrival time of the last passenger who boarded *any* bus

    // Simulate bus departures
    for (int i = 0; i < busesSize; ++i) {
        int current_bus_departure_time = buses[i];
        int passengers_boarded_on_this_bus = 0;

        // Board passengers for the current bus
        // A passenger can board if:
        // 1. There are still passengers to consider (`passenger_ptr < passengersSize`)
        // 2. The passenger arrives on or before the bus departure time (`passengers[passenger_ptr] <= current_bus_departure_time`)
        // 3. The bus still has capacity (`passengers_boarded_on_this_bus < capacity`)
        while (passenger_ptr < passengersSize &&
               passengers[passenger_ptr] <= current_bus_departure_time &&
               passengers_boarded_on_this_bus < capacity) {

            last_passenger_boarded_time = passengers[passenger_ptr]; // Update the time of the last boarded passenger
            passengers_boarded_on_this_bus++;
            passenger_ptr++;
        }

        // When we are processing the last bus, we determine the latest possible arrival time
        if (i == busesSize - 1) {
            int result_time;

            if (passengers_boarded_on_this_bus < capacity) {
                // Case 1: The last bus is not full.
                // We can potentially arrive at any time up to `current_bus_departure_time`.
                // The latest possible time is `current_bus_departure_time` itself,
                // unless it's an existing passenger's arrival time.
                result_time = current_bus_departure_time;
            } else {
                // Case 2: The last bus is full.
                // We must arrive strictly before the last passenger who boarded this specific bus.
                // `last_passenger_boarded_time` holds the arrival time of that passenger.
                result_time = last_passenger_boarded_time - 1;
            }

            // Now, we need to find the largest `t` such that `t >= 1`, `t <= result_time` (our initial candidate),
            // and `t` is not an existing passenger's arrival time.

            // `p_idx` is initialized to point to the last passenger who boarded *any* bus.
            // `passenger_ptr` is the index of the first passenger *not yet considered*.
            // So, `passengers[0]` to `passengers[passenger_ptr - 1]` are the passengers who have boarded.
            int p_idx = passenger_ptr - 1; 

            // Iterate downwards from `result_time` to find the actual latest valid time.
            // We stop when `result_time` is not an existing passenger's arrival time, or `result_time` becomes 0.
            // The problem guarantees a valid positive arrival time can always be found, so `result_time` will not become 0.
            while (result_time >= 1) {
                // If `p_idx` is valid and `result_time` is equal to `passengers[p_idx]`,
                // it means `result_time` is an existing passenger's arrival time.
                // So, we decrement `result_time` and move `p_idx` to check the previous passenger.
                if (p_idx >= 0 && passengers[p_idx] == result_time) {
                    result_time--;
                    p_idx--;
                } else {
                    // `result_time` is not equal to `passengers[p_idx]` (either `p_idx < 0`, or `passengers[p_idx] < result_time`, or `passengers[p_idx] > result_time`).
                    // In any of these cases, `result_time` is not taken by `passengers[p_idx]` or any earlier passenger.
                    // Therefore, `result_time` is the latest valid time we can arrive.
                    break;
                }
            }
            return result_time;
        }
    }

    // This part should theoretically not be reached given the problem constraints (busesSize >= 1)
    // and the guarantee that a valid arrival time can always be found.
    return 0; // Fallback return, though it implies an unhandled edge case or contradiction with problem guarantees.
}