var maxNumberOfFamilies = function(n, reservedSeats) {
    const reserved = new Map();
    for (const [row, seat] of reservedSeats) {
        if (!reserved.has(row)) {
            reserved.set(row, new Set());
        }
        reserved.get(row).add(seat);
    }

    let result = 2 * (n - reserved.size);

    for (const [row, seats] of reserved) {
        let canFit = 0;
        if (!seats.has(2) && !seats.has(3) && !seats.has(4) && !seats.has(5)) {
            canFit++;
        }
        if (!seats.has(6) && !seats.has(7) && !seats.has(8) && !seats.has(9)) {
            canFit++;
        }
        if (canFit === 0 && !seats.has(4) && !seats.has(5) && !seats.has(6) && !seats.has(7)) {
            canFit = 1;
        }
        result += canFit;
    }

    return result;
};