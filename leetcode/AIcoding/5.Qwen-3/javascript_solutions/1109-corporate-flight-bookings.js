function corpFlightBookings(n, bookings) {
    const res = new Array(n).fill(0);
    for (const [l, r, k] of bookings) {
        res[l - 1] += k;
        if (r < n) res[r] -= k;
    }
    for (let i = 1; i < n; i++) {
        res[i] += res[i - 1];
    }
    return res;
}