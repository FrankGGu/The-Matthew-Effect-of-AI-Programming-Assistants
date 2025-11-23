var minTime = function(problems, limit) {
    let low = 0;
    let high = 0;

    for (let p of problems) {
        low = Math.max(low, p);
        high += p;
    }

    let ans = high;

    const check = (maxTime) => {
        let days = 1;
        let currentDayTime = 0;
        for (let p of problems) {
            if (currentDayTime + p <= maxTime) {
                currentDayTime += p;
            } else {
                days++;
                currentDayTime = p;
            }
        }
        return days <= limit;
    };

    while (low <= high) {
        let mid = low + Math.floor((high - low) / 2);
        if (check(mid)) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    return ans;
};