var maxNumberOfFamilies = function(n, reservedSeats) {
    const reservedMap = new Map();

    for (const [row, seat] of reservedSeats) {
        if (!reservedMap.has(row)) {
            reservedMap.set(row, new Set());
        }
        reservedMap.get(row).add(seat);
    }

    let count = n * 2;

    for (const [row, seats] of reservedMap.entries()) {
        let left = true;
        let middle = true;
        let right = true;

        for (let i = 2; i <= 9; i++) {
            if (i >= 2 && i <= 5) {
                if (seats.has(i)) left = false;
            }
            if (i >= 4 && i <= 7) {
                if (seats.has(i)) middle = false;
            }
            if (i >= 6 && i <= 9) {
                if (seats.has(i)) right = false;
            }
        }

        if (!left && !middle && !right) {
            count -= 2;
        } else if (!left || !middle || !right) {
            count--;
        }
    }

    return count;
};