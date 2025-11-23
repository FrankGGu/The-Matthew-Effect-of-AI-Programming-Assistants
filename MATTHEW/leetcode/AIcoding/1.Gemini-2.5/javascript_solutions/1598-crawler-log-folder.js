var minOperations = function(logs) {
    let depth = 0;

    for (const log of logs) {
        if (log === "../") {
            if (depth > 0) {
                depth--;
            }
        } else if (log === "./") {
            // Stay in the current folder, no change to depth
        } else {
            // Move into a child folder
            depth++;
        }
    }

    return depth;
};