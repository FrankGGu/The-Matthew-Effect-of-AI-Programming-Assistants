var hIndex = function(citations) {
    let n = citations.length;
    let left = 0, right = n - 1;

    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        if (citations[mid] < n - mid) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return n - left;
};