var maxNumberOfFamilies = function(n, reservedSeats) {
    let reserved = new Map();
    for (let seat of reservedSeats) {
        let row = seat[0];
        let col = seat[1];
        if (!reserved.has(row)) {
            reserved.set(row, new Set());
        }
        reserved.get(row).add(col);
    }

    let count = 2 * n;
    for (let [row, seats] of reserved) {
        let left = true;
        let middle = true;
        let right = true;

        for (let seat of seats) {
            if (seat >= 2 && seat <= 5) {
                left = false;
            }
            if (seat >= 4 && seat <= 7) {
                middle = false;
            }
            if (seat >= 6 && seat <= 9) {
                right = false;
            }
        }

        if (left && middle && right) {
            continue;
        } else if (left && middle) {
            count--;
        } else if (middle && right) {
            count--;
        } else if (left && right) {
            count--;
        } else if (left) {
            count--;
        } else if (middle) {
            count--;
        } else if (right) {
            count--;
        } else {
            count -= 2;
        }
    }

    return count;
};