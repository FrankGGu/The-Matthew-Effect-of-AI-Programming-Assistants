var minimumBuckets = function(hamsters) {
    const n = hamsters.length;
    const arr = hamsters.split('');
    let buckets = 0;

    for (let i = 0; i < n; i++) {
        if (arr[i] === 'H') {
            // Check if this hamster is already fed by a bucket to its left
            if (i > 0 && arr[i - 1] === 'B') {
                continue;
            }

            // Try to place a bucket to its right (most optimal as it can feed H at i and H at i+2)
            if (i + 1 < n && arr[i + 1] === '.') {
                arr[i + 1] = 'B'; // Place bucket
                buckets++;
                // This bucket at i+1 feeds H at i. It also feeds H at i+2 if it's an H.
                // So, we can skip checking i+2 in the next iteration.
                // The loop's i++ will then make it i+3.
                i += 2; 
            } 
            // If placing to the right is not possible, try placing to its left
            else if (i - 1 >= 0 && arr[i - 1] === '.') {
                arr[i - 1] = 'B'; // Place bucket
                buckets++;
            } 
            // If neither left nor right is available for a new bucket, it's impossible to feed this hamster
            else {
                return -1;
            }
        }
    }

    return buckets;
};