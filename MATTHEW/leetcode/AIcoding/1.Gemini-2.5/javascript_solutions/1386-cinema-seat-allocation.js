var maxNumberOfFamilies = function(n, reservedSeats) {
    const rowMap = new Map(); // Map<rowNumber, Set<columnNumber>>

    for (const [row, col] of reservedSeats) {
        if (!rowMap.has(row)) {
            rowMap.set(row, new Set());
        }
        rowMap.get(row).add(col);
    }

    let families = 0;

    for (const [row, reservedCols] of rowMap) {
        let currentFamiliesInRow = 0;

        // Check for two disjoint groups: [2,3,4,5] and [6,7,8,9]
        // Group 1: Seats 2, 3, 4, 5
        const group1Available = !(reservedCols.has(2) || reservedCols.has(3) || reservedCols.has(4) || reservedCols.has(5));
        // Group 3: Seats 6, 7, 8, 9
        const group3Available = !(reservedCols.has(6) || reservedCols.has(7) || reservedCols.has(8) || reservedCols.has(9));

        if (group1Available && group3Available) {
            currentFamiliesInRow = 2;
        } else {
            // If two disjoint groups are not possible, check if any single group can be seated.
            // Group 2: Seats 4, 5, 6, 7 (overlaps with both group 1 and group 3)
            const group2Available = !(reservedCols.has(4) || reservedCols.has(5) || reservedCols.has(6) || reservedCols.has(7));

            if (group1Available || group2Available || group3Available) {
                currentFamiliesInRow = 1;
            }
        }
        families += currentFamiliesInRow;
    }

    // Add families from rows that have no reservations.
    // Each such row can seat 2 families (e.g., in [2,3,4,5] and [6,7,8,9]).
    families += (n - rowMap.size) * 2;

    return families;
};