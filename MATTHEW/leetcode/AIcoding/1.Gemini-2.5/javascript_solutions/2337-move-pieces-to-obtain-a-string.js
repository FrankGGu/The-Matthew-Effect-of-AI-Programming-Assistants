var canChange = function(start, target) {
    const n = start.length;
    let i = 0; // Pointer for the start string
    let j = 0; // Pointer for the target string

    // Iterate as long as there are characters to process in either string
    while (i < n || j < n) {
        // Advance pointer i past any underscores in the start string
        while (i < n && start[i] === '_') {
            i++;
        }
        // Advance pointer j past any underscores in the target string
        while (j < n && target[j] === '_') {
            j++;
        }

        // If both pointers have reached the end, it means all non-underscore characters
        // have been matched and validated.
        if (i === n && j === n) {
            return true;
        }

        // If one pointer has reached the end but the other hasn't, it means
        // there's a mismatch in the number or sequence of 'L'/'R' characters.
        if (i === n || j === n) {
            return false;
        }

        // At this point, both start[i] and target[j] point to non-underscore characters.
        // They must be the same character to maintain the relative order of 'L' and 'R'.
        if (start[i] !== target[j]) {
            return false;
        }

        // Check movement constraints:
        // 'L' can only move to the left (target position j must be less than or equal to start position i).
        if (start[i] === 'L') {
            if (j > i) {
                return false;
            }
        } 
        // 'R' can only move to the right (target position j must be greater than or equal to start position i).
        else { // start[i] === 'R'
            if (j < i) {
                return false;
            }
        }

        // Move to the next pair of non-underscore characters
        i++;
        j++;
    }

    // This line should theoretically not be reached if the first `if (i === n && j === n)`
    // correctly handles the final state of the loop. It's a safeguard.
    return true;
};