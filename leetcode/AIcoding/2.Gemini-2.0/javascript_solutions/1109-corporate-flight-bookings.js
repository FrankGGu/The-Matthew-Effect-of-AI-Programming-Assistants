var corpFlightBookings = function(bookings, n) {
    const result = new Array(n).fill(0);
    for (const booking of bookings) {
        const start = booking[0] - 1;
        const end = booking[1] - 1;
        const seats = booking[2];

        result[start] += seats;
        if (end + 1 < n) {
            result[end + 1] -= seats;
        }
    }

    for (let i = 1; i < n; i++) {
        result[i] += result[i - 1];
    }

    return result;
};