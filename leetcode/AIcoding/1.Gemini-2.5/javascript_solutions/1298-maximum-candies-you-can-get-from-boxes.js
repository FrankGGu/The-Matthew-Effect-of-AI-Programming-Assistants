var maxCandies = function(status, candies, keys, containedBoxes, initialBoxes) {
    let totalCandies = 0;
    const n = status.length;

    // hasKey[i] is true if we possess a key for box i
    const hasKey = new Array(n).fill(false);
    // processed[i] is true if we have already opened box i and collected its contents
    const processed = new Array(n).fill(false);
    // found[i] is true if we have encountered box i (either initially or inside another box)
    const found = new Array(n).fill(false);

    // queue for boxes that are currently openable and not yet processed
    const queue = [];
    // Set for boxes that are found, but closed, and we don't have a key for them yet
    const waitingForKeys = new Set();

    // Initialize with initialBoxes
    for (const boxIdx of initialBoxes) {
        found[boxIdx] = true;
        if (status[boxIdx] === 1) { // Box is initially open
            queue.push(boxIdx);
        } else { // Box is initially closed
            waitingForKeys.add(boxIdx);
        }
    }

    // BFS loop
    let head = 0; // Using head pointer for queue for better performance than shift()
    while (head < queue.length) {
        const currBox = queue[head++];

        if (processed[currBox]) {
            continue; // Already processed this box
        }

        processed[currBox] = true;
        totalCandies += candies[currBox];

        // Process keys found in currBox
        for (const keyForBoxIdx of keys[currBox]) {
            if (!hasKey[keyForBoxIdx]) { // Only process if this is a new key
                hasKey[keyForBoxIdx] = true;
                // If this key unlocks a box we've found but couldn't open:
                if (waitingForKeys.has(keyForBoxIdx)) {
                    waitingForKeys.delete(keyForBoxIdx);
                    queue.push(keyForBoxIdx); // Add it to the queue to be processed
                }
            }
        }

        // Process boxes found inside currBox
        for (const innerBoxIdx of containedBoxes[currBox]) {
            if (!found[innerBoxIdx]) { // If this is a newly found box
                found[innerBoxIdx] = true;
                if (status[innerBoxIdx] === 1 || hasKey[innerBoxIdx]) { // It's openable now
                    queue.push(innerBoxIdx);
                } else { // It's closed and we don't have a key yet
                    waitingForKeys.add(innerBoxIdx);
                }
            } else { // We've found this box before
                // If it's in waitingForKeys and we now have a key for it, move it to queue.
                // Note: It might already be in the queue if it was found and openable earlier,
                // or already processed. The 'processed' check at the start of the loop handles this.
                if (waitingForKeys.has(innerBoxIdx) && hasKey[innerBoxIdx]) {
                    waitingForKeys.delete(innerBoxIdx);
                    queue.push(innerBoxIdx);
                }
            }
        }
    }

    return totalCandies;
};