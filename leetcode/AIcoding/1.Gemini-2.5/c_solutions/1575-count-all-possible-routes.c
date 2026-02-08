#include <stdlib.h> // For abs

int memo[100][201]; 

int* g_locations;
int g_locationsSize;
int g_finish;
int MOD = 1e9 + 7;

int solve(int current_city, int current_fuel) {
    // If fuel runs out, this path is invalid.
    if (current_fuel < 0) {
        return 0;
    }

    // If this state has been computed before, return the stored result.
    if (memo[current_city][current_fuel] != -1) {
        return memo[current_city][current_fuel];
    }

    // Initialize count for routes starting from current_city with current_fuel.
    // If current_city is the finish city, this path itself counts as one route.
    // We can still continue traveling from here to find more routes.
    long long count = 0;
    if (current_city == g_finish) {
        count = 1;
    }

    // Explore all possible next cities
    for (int next_city = 0; next_city < g_locationsSize; next_city++) {
        // Cannot travel to the same city (distance is 0, but problem implies distinct cities for travel)
        // Or rather, the problem implies moving between distinct locations.
        // If current_city == next_city, fuel_needed would be 0, leading to infinite loops if not handled.
        if (next_city == current_city) {
            continue;
        }

        int fuel_needed = abs(g_locations[current_city] - g_locations[next_city]);

        // If we have enough fuel to travel to the next_city
        if (current_fuel >= fuel_needed) {
            // Add the number of routes from next_city with remaining fuel
            count = (count + solve(next_city, current_fuel - fuel_needed)) % MOD;
        }
    }

    // Store the computed result in the memoization table and return it.
    return memo[current_city][current_fuel] = (int)count;
}

int countRoutes(int* locations, int locationsSize, int start, int finish, int fuel) {
    // Assign global variables
    g_locations = locations;
    g_locationsSize = locationsSize;
    g_finish = finish;

    // Initialize memoization table with -1 to indicate uncomputed states
    for (int i = 0; i < locationsSize; i++) {
        for (int j = 0; j <= fuel; j++) {
            memo[i][j] = -1;
        }
    }

    // Start the recursive calculation from the initial state
    return solve(start, fuel);
}