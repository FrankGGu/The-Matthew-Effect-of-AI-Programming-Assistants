var threeEqualParts = function(arr) {
    let totalOnes = 0;
    for (let x of arr) {
        if (x === 1) {
            totalOnes++;
        }
    }

    if (totalOnes === 0) {
        // If all elements are 0, any split that results in three parts
        // with value 0 is valid.
        // We need i+1 <= j-1, which means j > i+1.
        // For example, if arr = [0,0,0], i=0, j=2 works: [0], [0], [0]. All value 0.
        // If arr = [0,0,0,0], i=0, j=2 works: [0], [0], [0,0]. All value 0.
        // This requires arr.length >= 3.
        return arr.length >= 3 ? [0, 2] : [-1, -1];
    }

    if (totalOnes % 3 !== 0) {
        return [-1, -1];
    }

    const onesPerPart = totalOnes / 3;

    let start1 = -1, end1 = -1;
    let start2 = -1, end2 = -1;
    let start3 = -1, end3 = -1;

    let currentOneCount = 0;
    for (let i = 0; i < arr.length; i++) {
        if (arr[i] === 1) {
            currentOneCount++;
            if (currentOneCount === 1) { // First '1' of part 1
                start1 = i;
            } else if (currentOneCount === onesPerPart) { // Last '1' of part 1
                end1 = i;
            } else if (currentOneCount === onesPerPart + 1) { // First '1' of part 2
                start2 = i;
            } else if (currentOneCount === 2 * onesPerPart) { // Last '1' of part 2
                end2 = i;
            } else if (currentOneCount === 2 * onesPerPart + 1) { // First '1' of part 3
                start3 = i;
            } else if (currentOneCount === 3 * onesPerPart) { // Last '1' of part 3
                end3 = i;
            }
        }
    }

    // The number of trailing zeros required for each part is determined by the last part.
    const numTrailingZeros = arr.length - 1 - end3;

    // Check if there are enough zeros between the 'core' parts to accommodate numTrailingZeros.
    // The segment arr[end1+1 ... start2-1] contains zeros after part1's last '1' and before part2's first '1'.
    // Its length is (start2-1) - (end1+1) + 1 = start2 - end1 - 1.
    if (start2 - end1 - 1 < numTrailingZeros || start3 - end2 - 1 < numTrailingZeros) {
        return [-1, -1];
    }

    // Compare the "core" parts (the segments from the first '1' to the last '1' in each part).
    // These must be identical for the parts to represent the same binary value.
    // The length of the core part of the first segment is `end1 - start1 + 1`.
    for (let k = 0; k <= end1 - start1; k++) {
        if (arr[start1 + k] !== arr[start2 + k] || arr[start1 + k] !== arr[start3 + k]) {
            return [-1, -1];
        }
    }

    // If all checks pass, we can determine i and j.
    // The first part ends at `end1 + numTrailingZeros`.
    // The second part starts at `end1 + numTrailingZeros + 1` and ends at `end2 + numTrailingZeros`.
    // The third part starts at `end2 + numTrailingZeros + 1`.
    return [end1 + numTrailingZeros, end2 + numTrailingZeros + 1];
};