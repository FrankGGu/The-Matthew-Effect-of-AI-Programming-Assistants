var takeAttendance = function(records) {
    let left = 0, right = records.length - 1;
    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        if (records[mid] === mid) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return left;
};