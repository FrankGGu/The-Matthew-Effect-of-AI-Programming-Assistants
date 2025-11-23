function peakIndexInMountainArray(time) {
    let left = 0, right = time.length - 1;
    while (left < right) {
        let mid = Math.floor((left + right) / 2);
        if (time[mid] < time[mid + 1]) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    return [left];
}