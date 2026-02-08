var solution = function(isBadVersion) {

    return function(n) {
        let left = 1;
        let right = n;
        let firstBad = n;

        while (left <= right) {
            let mid = left + Math.floor((right - left) / 2);
            if (isBadVersion(mid)) {
                firstBad = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        return firstBad;
    };
};