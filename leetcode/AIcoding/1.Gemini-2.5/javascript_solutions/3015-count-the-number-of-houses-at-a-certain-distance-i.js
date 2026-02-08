var countOfPairs = function(n, x, y) {
    // Initialize the answer array. ans[k] will store the count of pairs with distance k.
    // The problem asks for an array of size n, where ans[k] is for distance k.
    // The minimum distance between distinct houses is 1, so ans[0] will always be 0.
    // The maximum possible distance is n-1.
    const ans = new Array(n).fill(0);

    // Determine if an effective extra connection exists.
    // An extra connection is considered effective if x and y are distinct, non-zero house numbers.
    let hasExtraConnection = false;
    let actualX = x;
    let actualY = y;
    if (x !== 0 && y !== 0 && x !== y) {
        hasExtraConnection = true;
        // Normalize actualX and actualY to ensure actualX <= actualY for consistent calculations.
        if (actualX > actualY) {
            [actualX, actualY] = [actualY, actualX];
        }
    }

    // Iterate through all possible pairs (i, j) where i < j
    for (let i = 1; i <= n; i++) {
        for (let j = i + 1; j <= n; j++) {
            // Calculate the distance along the direct line path
            let currentMinDist = j - i;

            // If an effective extra connection exists, consider paths through it
            if (hasExtraConnection) {
                // Path 1: i -> actualX -> actualY -> j
                // Distance: |i - actualX| + 1 (for the actualX-actualY edge) + |actualY - j|
                let distViaXY = Math.abs(i - actualX) + 1 + Math.abs(actualY - j);
                currentMinDist = Math.min(currentMinDist, distViaXY);

                // Path 2: i -> actualY -> actualX -> j
                // Distance: |i - actualY| + 1 (for the actualY-actualX edge) + |actualX - j|
                let distViaYX = Math.abs(i - actualY) + 1 + Math.abs(actualX - j);
                currentMinDist = Math.min(currentMinDist, distViaYX);
            }

            // Increment the count for the calculated shortest distance
            ans[currentMinDist]++;
        }
    }

    return ans;
};