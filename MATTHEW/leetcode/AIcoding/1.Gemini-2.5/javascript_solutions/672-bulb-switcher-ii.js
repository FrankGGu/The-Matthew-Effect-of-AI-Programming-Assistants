var flipLights = function(n, m) {
    if (m === 0) {
        return 1;
    }

    if (n === 1) {
        return 2;
    }

    if (n === 2) {
        // For m=1, the possible states are:
        // [0,0] (initial)
        // [1,1] (Flip all)
        // [0,1] (Flip even)
        // [1,0] (Flip odd or Flip 3k+1)
        // These are 4 distinct states.
        // For m >= 2, all 4 states are still reachable.
        return 4;
    }

    // n >= 3
    if (m === 1) {
        // For m=1, the possible states are:
        // [0,0,0] (initial)
        // [1,1,1] (Flip all)
        // [0,1,0] (Flip even)
        // [1,0,1] (Flip odd)
        // [1,0,0] (Flip 3k+1)
        // These are 5 distinct states.
        return 5;
    } else { // m >= 2
        // For n >= 3 and m >= 2, all 8 possible distinct states for the first 3 bulbs
        // (which determine the pattern for all bulbs) are reachable.
        return 8;
    }
};