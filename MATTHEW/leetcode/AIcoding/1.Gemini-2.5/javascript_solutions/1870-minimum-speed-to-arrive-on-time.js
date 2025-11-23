var minSpeedOnTime = function(dist, hour) {
    const n = dist.length;

    // Edge case: If there's more than one train ride, each ride (except the last one)
    // takes at least 1 hour because speed must be at least 1 and distance is positive.
    // So, n-1 rides take at least n-1 hours. The last ride also takes positive time.
    // Therefore, total time must be strictly greater than n-1.
    // If hour is less than or equal to n-1, it's impossible to finish on time.
    if (n > 1 && hour <= n - 1) {
        return -1;
    }

    let left = 1;
    // A sufficiently large upper bound for speed.
    // The maximum possible distance is 10^5. If hour - (n-1) is very small (e.g., 10^-9),
    // speed could be up to 10^5 / 10^-9 = 10^14.
    // Using 10^14 as a safe upper bound.
    let right = 10**14; 
    let ans = -1;

    while (left <= right) {
        const mid = Math.floor(left + (right - left) / 2);
        let totalTime = 0.0;

        // Calculate total time for the given speed 'mid'
        for (let i = 0; i < n - 1; i++) {
            // For all but the last leg, time is rounded up to the nearest integer
            totalTime += Math.ceil(dist[i] / mid);
        }
        // For the last leg, time is not rounded up
        totalTime += dist[n - 1] / mid;

        // Check if this speed is feasible
        if (totalTime <= hour) {
            ans = mid;         // This speed is feasible, store it as a potential answer
            right = mid - 1;   // Try to find a smaller speed
        } else {
            left = mid + 1;    // This speed is too slow, need a larger speed
        }
    }

    return ans;
};