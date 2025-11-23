var minimumPartition = function(s, k) {
    let count = 0;
    let i = 0;

    while (i < s.length) {
        count++;
        let currentNum = 0;

        while (i < s.length) {
            const digit = parseInt(s[i]);

            if (digit === 0) {
                if (currentNum === 0) {
                    // If currentNum is 0 and we encounter '0', this '0' must form its own partition.
                    // We consume it and break to start a new partition.
                    i++;
                    break; 
                } else {
                    // currentNum > 0, try to append '0'
                    const nextNum = currentNum * 2;
                    if (nextNum <= k) {
                        currentNum = nextNum;
                        i++;
                    } else {
                        // Cannot append '0', current partition ends.
                        break;
                    }
                }
            } else { // digit === 1
                // Check if appending '1' would exceed k.
                // If currentNum is 0, nextNum would be 1. Since k >= 1, '1' is always a valid start.
                // If currentNum * 2 + 1 > k, then we must start a new partition with '1'.
                const nextNum = currentNum * 2 + 1;
                if (nextNum <= k) {
                    currentNum = nextNum;
                    i++;
                } else {
                    // Cannot append '1', current partition ends.
                    break;
                }
            }
        }
    }

    return count;
};