var shipWithinDays = function(packages, D) {
    let left = 0;
    let right = 0;
    for (let weight of packages) {
        left = Math.max(left, weight);
        right += weight;
    }

    let ans = right;

    while (left <= right) {
        let mid = Math.floor((left + right) / 2);

        let daysNeeded = 1;
        let currentWeight = 0;
        for (let weight of packages) {
            if (currentWeight + weight > mid) {
                daysNeeded++;
                currentWeight = weight;
            } else {
                currentWeight += weight;
            }
        }

        if (daysNeeded <= D) {
            ans = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return ans;
};