function maxNumberOfFamilies(n, reservedSeats) {
    const reserved = Array.from({ length: n }, () => new Set());
    for (const [row, seat] of reservedSeats) {
        reserved[row - 1].add(seat);
    }

    let maxFamilies = 0;

    for (const row of reserved) {
        let count = 0;
        if (!reserved[row].has(2) && !reserved[row].has(3) && !reserved[row].has(4)) count++; // 1,2,3,4
        if (!reserved[row].has(4) && !reserved[row].has(5) && !reserved[row].has(6)) count++; // 4,5,6,7
        if (!reserved[row].has(6) && !reserved[row].has(7) && !reserved[row].has(8)) count++; // 7,8,9,10
        maxFamilies += count;
    }

    return maxFamilies + (n - reserved.length) * 2; // Each empty row can have 2 families
}