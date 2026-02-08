var numFriendRequests = function(ages) {
    ages.sort((a, b) => a - b);
    let count = 0;
    for (let i = 0; i < ages.length; i++) {
        let age = ages[i];
        let start = 0;
        let end = i - 1;
        let l = -1;
        while (start <= end) {
            let mid = Math.floor((start + end) / 2);
            if (ages[mid] > 0.5 * age + 7) {
                l = mid;
                end = mid - 1;
            } else {
                start = mid + 1;
            }
        }

        start = i + 1;
        end = ages.length - 1;
        let r = -1;
        while (start <= end) {
            let mid = Math.floor((start + end) / 2);
            if (ages[mid] <= age) {
                r = mid;
                start = mid + 1;
            } else {
                end = mid - 1;
            }
        }

        if (l !== -1 && r !== -1) {
            count += (r - l + 1);
        }
    }
    return count;
};