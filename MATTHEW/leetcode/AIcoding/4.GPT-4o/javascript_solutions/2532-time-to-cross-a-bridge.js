function findCrossingTime(n, k, time) {
    let left = 0, right = 1e10, ans = 0;

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        const totalCars = Math.floor(mid / time[0][0]);
        const totalCrossed = Math.min(totalCars, n);

        if (totalCrossed >= n) {
            ans = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return ans;
}