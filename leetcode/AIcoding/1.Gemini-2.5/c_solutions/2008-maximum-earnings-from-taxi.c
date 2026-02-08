#include <stdlib.h> // For malloc, free, qsort
#include <string.h> // For memset (though calloc is used which initializes to zero)

typedef struct {
    int start;
    int end;
    int tip;
} Ride;

int compareRides(const void* a, const void* b) {
    Ride* rideA = (Ride*)a;
    Ride* rideB = (Ride*)b;

    if (rideA->end != rideB->end) {
        return rideA->end - rideB->end;
    }
    return rideA->start - rideB->start;
}

long long max(long long a, long long b) {
    return a > b ? a : b;
}

long long maxTaxiEarnings(int n, int** rides, int ridesSize, int* ridesColSize) {
    // 1. Create an array of Ride structs from the input 2D array
    // This allows us to use qsort easily.
    Ride* ride_data = (Ride*)malloc(ridesSize * sizeof(Ride));
    if (ride_data == NULL && ridesSize > 0) {
        // Handle allocation failure if ridesSize > 0, though LeetCode usually guarantees success
        return 0; 
    }

    for (int i = 0; i < ridesSize; ++i) {
        ride_data[i].start = rides[i][0];
        ride_data[i].end = rides[i][1];
        ride_data[i].tip = rides[i][2];
    }

    // 2. Sort the rides using the custom comparison function
    qsort(ride_data, ridesSize, sizeof(Ride), compareRides);

    // 3. Initialize the dynamic programming array
    // dp[i] will store the maximum earnings considering rides that end at or before point i.
    // The array size is n+1 because points are 1-indexed up to n.
    // calloc initializes all elements to zero, which is perfect for our base case dp[0]=0.
    long long* dp = (long long*)calloc(n + 1, sizeof(long long));
    if (dp == NULL) {
        free(ride_data); // Clean up previously allocated memory
        return 0; // Handle allocation failure
    }

    // 4. Iterate through each point from 1 to n
    int ride_idx = 0; // Pointer to the current ride in the sorted array
    for (int i = 1; i <= n; ++i) {
        // Option 1: Don't take any ride that ends exactly at point 'i'.
        // In this case, the maximum earnings up to point 'i' are the same as up to point 'i-1'.
        dp[i] = dp[i-1];

        // Option 2: Consider all rides that end exactly at point 'i'.
        // Iterate through these rides (they are contiguous in the sorted array).
        while (ride_idx < ridesSize && ride_data[ride_idx].end == i) {
            Ride current_ride = ride_data[ride_idx];

            // Calculate the earnings for the current ride
            long long current_earning = (long long)current_ride.end - current_ride.start + current_ride.tip;

            // Update dp[i]:
            // The maximum earnings up to point 'i' is the max of:
            // a) Not taking any ride ending at 'i' (dp[i-1])
            // b) Taking the current ride: earnings from previous rides (up to current_ride.start) + current_earning
            dp[i] = max(dp[i], dp[current_ride.start] + current_earning);

            ride_idx++; // Move to the next ride in the sorted array
        }
    }

    // The maximum total earnings will be stored in dp[n]
    long long result = dp[n];

    // Free allocated memory to prevent memory leaks
    free(ride_data);
    free(dp);

    return result;
}