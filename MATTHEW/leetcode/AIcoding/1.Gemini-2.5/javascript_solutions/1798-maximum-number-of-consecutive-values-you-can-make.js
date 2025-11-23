var getMaximumConsecutive = function(coins) {
    coins.sort((a, b) => a - b);

    let reachable = 0; // Represents the maximum value k such that all integers from 0 to k can be formed.

    for (const coin of coins) {
        // If the current coin is greater than reachable + 1,
        // it means we cannot form reachable + 1, as all previous coins
        // (and their combinations) only allow us to reach up to 'reachable'.
        // The current coin 'coin' is too large to fill the gap at 'reachable + 1'.
        // Any subsequent coins will be even larger, so they won't help either.
        if (coin > reachable + 1) {
            break;
        }

        // If coin <= reachable + 1, we can use this coin to extend our range.
        // We can now form all values from 0 to 'reachable' (using previous coins)
        // AND we can form all values from 'coin' to 'reachable + coin' (by adding 'coin' to existing sums).
        // Since 'coin' <= 'reachable + 1', the interval [0, reachable] and [coin, reachable + coin]
        // will overlap or touch, forming a continuous range [0, reachable + coin].
        reachable += coin;
    }

    // The result is reachable + 1 because 'reachable' is the maximum value we can form,
    // and we are counting the number of consecutive values starting from 0 (i.e., 0, 1, ..., reachable).
    return reachable + 1;
};