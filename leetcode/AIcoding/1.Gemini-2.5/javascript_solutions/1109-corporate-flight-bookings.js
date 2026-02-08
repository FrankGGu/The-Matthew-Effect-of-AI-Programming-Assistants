var corpFlightBookings = function(bookings, n) {
    const ans = new Array(n).fill(0);

    for (const booking of bookings) {
        const first = booking[0];
        const last = booking[1];
        const seats = booking[2];

        ans[first - 1] += seats;
        if (last < n) {
            ans[last] -= seats;
        }
    }

    for (let i = 1; i < n; i++) {
        ans[i] += ans[i - 1];
    }

    return ans;
};