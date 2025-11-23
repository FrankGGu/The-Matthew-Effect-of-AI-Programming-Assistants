function takeAttendance(students) {
    let left = 0;
    let right = students.length - 1;
    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        if (students[mid] === mid + 1) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    return left + 1;
}