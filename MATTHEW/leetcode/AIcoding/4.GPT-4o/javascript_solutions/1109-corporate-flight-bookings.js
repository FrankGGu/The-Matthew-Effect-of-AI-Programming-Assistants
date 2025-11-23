var corpFlightBookings = function(bookings, n) {
    const flights = new Array(n).fill(0);
    for (const [start, end, seats] of bookings) {
        flights[start - 1] += seats;
        if (end < n) flights[end] -= seats;
    }
    for (let i = 1; i < n; i++) {
        flights[i] += flights[i - 1];
    }
    return flights;
};