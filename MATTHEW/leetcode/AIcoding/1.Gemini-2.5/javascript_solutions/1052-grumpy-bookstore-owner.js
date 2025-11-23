var maxSatisfied = function(customers, grumpy, minutes) {
    let n = customers.length;
    let baseSatisfied = 0;
    let maxWindowGain = 0;
    let currentWindowGain = 0;

    for (let i = 0; i < n; i++) {
        // Customers satisfied regardless of the secret technique
        if (grumpy[i] === 0) {
            baseSatisfied += customers[i];
        }

        // Calculate the potential gain from grumpy customers within the current window
        // This sum will be used for the sliding window maximum
        if (grumpy[i] === 1) {
            currentWindowGain += customers[i];
        }

        // If the window has moved past 'minutes' length,
        // remove the leftmost element's contribution from currentWindowGain
        if (i >= minutes) {
            if (grumpy[i - minutes] === 1) {
                currentWindowGain -= customers[i - minutes];
            }
        }

        // Update the maximum gain achievable by applying the technique for 'minutes' duration
        maxWindowGain = Math.max(maxWindowGain, currentWindowGain);
    }

    // The total satisfied customers is the sum of base satisfied customers
    // and the maximum additional customers gained by using the secret technique.
    return baseSatisfied + maxWindowGain;
};