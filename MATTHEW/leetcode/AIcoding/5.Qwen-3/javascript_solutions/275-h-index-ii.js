function hIndex(citations) {
    let left = 0, right = citations.length;
    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        if (citations[mid] >= citations.length - mid) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }
    return citations.length - left;
}