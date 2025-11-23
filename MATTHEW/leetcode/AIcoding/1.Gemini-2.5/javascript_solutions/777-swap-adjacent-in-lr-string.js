var canTransform = function(start, end) {
    const n = start.length;
    let i = 0; // Pointer for start string
    let j = 0; // Pointer for end string

    while (i < n && j < n) {
        // Skip 'X' characters in start string
        while (i < n && start[i] === 'X') {
            i++;
        }
        // Skip 'X' characters in end string
        while (j < n && end[j] === 'X') {
            j++;
        }

        // If one pointer reached end but the other didn't (for non-'X' chars)
        if (i === n || j === n) {
            break;
        }

        // Non-'X' characters must match
        if (start[i] !== end[j]) {
            return false;
        }

        // 'L' can only move left, so its index in start must be >= its index in end
        // If start[i] is 'L' and i < j, it means 'L' moved right, which is impossible.
        if (start[i] === 'L' && i < j) {
            return false;
        }

        // 'R' can only move right, so its index in start must be <= its index in end
        // If start[i] is 'R' and i > j, it means 'R' moved left, which is impossible.
        if (start[i] === 'R' && i > j) {
            return false;
        }

        i++;
        j++;
    }

    // After the loop, ensure both pointers have reached the end,
    // skipping any remaining 'X' characters.
    while (i < n && start[i] === 'X') {
        i++;
    }
    while (j < n && end[j] === 'X') {
        j++;
    }

    // If both pointers reached the end of their respective strings, it's a valid transformation.
    return i === n && j === n;
};