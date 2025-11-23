var maxEnvelopes = function(envelopes) {
    if (envelopes.length === 0) {
        return 0;
    }

    envelopes.sort((a, b) => {
        if (a[0] !== b[0]) {
            return a[0] - b[0];
        } else {
            return b[1] - a[1];
        }
    });

    const heights = envelopes.map(env => env[1]);

    const tails = [];

    const lowerBound = (arr, target) => {
        let low = 0;
        let high = arr.length;
        while (low < high) {
            let mid = Math.floor(low + (high - low) / 2);
            if (arr[mid] < target) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        return low;
    };

    for (const height of heights) {
        const index = lowerBound(tails, height);
        if (index === tails.length) {
            tails.push(height);
        } else {
            tails[index] = height;
        }
    }

    return tails.length;
};