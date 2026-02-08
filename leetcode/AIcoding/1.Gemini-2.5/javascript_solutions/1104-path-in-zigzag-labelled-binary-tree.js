var pathInZigZagTree = function(label) {
    const path = [];
    let currentLabel = label;

    while (currentLabel >= 1) {
        path.push(currentLabel);

        // Determine the level of the currentLabel
        // Level l has values from 2^(l-1) to 2^l - 1
        let l = Math.floor(Math.log2(currentLabel)) + 1;

        // Calculate min and max values for the current level
        let minVal = 1 << (l - 1); // 2^(l-1)
        let maxVal = (1 << l) - 1; // 2^l - 1

        // Determine the parent
        // If current level l is odd (1, 3, 5...), it's labelled L-R.
        // Its "standard" value is currentLabel itself.
        // Its parent in a standard tree would be Math.floor(currentLabel / 2).
        // This parent is at level l-1, which is an even level (2, 4, 6...).
        // Even levels are labelled R-L. So, the parent's standard value needs to be converted to its zigzag label.
        // The conversion formula for a value `v` at an even level `p_l` is `minVal_p + maxVal_p - v`.
        // So, parent's label = (1 << (l-2)) + ((1 << (l-1)) - 1) - Math.floor(currentLabel / 2).

        // If current level l is even (2, 4, 6...), it's labelled R-L.
        // Its "standard" value is `minVal + maxVal - currentLabel`.
        // Its parent in a standard tree would be Math.floor((minVal + maxVal - currentLabel) / 2).
        // This parent is at level l-1, which is an odd level (1, 3, 5...).
        // Odd levels are labelled L-R. So, the parent's label IS its standard value.
        // So, parent's label = Math.floor((minVal + maxVal - currentLabel) / 2).

        if (l % 2 === 1) { // Current level is odd (L-R)
            let parentStdVal = Math.floor(currentLabel / 2);

            let parentLevel = l - 1;
            // No need to calculate minValParent and maxValParent if parentLevel is 0 (root's parent)
            // The loop condition `currentLabel >= 1` handles termination when currentLabel becomes 0.
            if (parentLevel > 0) {
                let minValParent = 1 << (parentLevel - 1);
                let maxValParent = (1 << parentLevel) - 1;
                currentLabel = minValParent + maxValParent - parentStdVal;
            } else {
                currentLabel = 0; // Reached root, next is 0 to terminate
            }
        } else { // Current level is even (R-L)
            let stdPos = minVal + maxVal - currentLabel;
            currentLabel = Math.floor(stdPos / 2);
        }
    }

    return path.reverse();
};