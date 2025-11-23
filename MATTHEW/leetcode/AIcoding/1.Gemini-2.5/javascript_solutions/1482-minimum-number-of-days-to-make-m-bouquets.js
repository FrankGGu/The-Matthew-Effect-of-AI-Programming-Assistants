var minDays = function(bloomDay, m, k) {
    if (m * k > bloomDay.length) {
        return -1;
    }

    let low = 1;
    let high = 0;
    for (let day of bloomDay) {
        if (day > high) {
            high = day;
        }
    }

    let ans = -1;

    while (low <= high) {
        let mid = Math.floor((low + high) / 2);

        if (check(bloomDay, m, k, mid)) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    return ans;
};

function check(bloomDay, m, k, day) {
    let bouquetsMade = 0;
    let currentStreak = 0;

    for (let i = 0; i < bloomDay.length; i++) {
        if (bloomDay[i] <= day) {
            currentStreak++;
            if (currentStreak === k) {
                bouquetsMade++;
                currentStreak = 0;
            }
        } else {
            currentStreak = 0;
        }
    }

    return bouquetsMade >= m;
}