var maxNumberOfFamilies = function(n, reservedSeats) {
    const reserved = {};
    for (const [row, seat] of reservedSeats) {
        if (!reserved[row]) {
            reserved[row] = new Set();
        }
        reserved[row].add(seat);
    }

    let result = 2 * n;

    for (const row in reserved) {
        const seats = reserved[row];
        let count = 0;

        if (!seats.has(2) && !seats.has(3) && !seats.has(4) && !seats.has(5)) {
            count++;
            if (!seats.has(6) && !seats.has(7) && !seats.has(8) && !seats.has(9)) {
                count++;
            }
        } else if (!seats.has(6) && !seats.has(7) && !seats.has(8) && !seats.has(9)) {
            count++;
        } else if (!seats.has(4) && !seats.has(5) && !seats.has(6) && !seats.has(7)) {
            count++;
        }

        result -= (2 - count);
    }

    return result;
};