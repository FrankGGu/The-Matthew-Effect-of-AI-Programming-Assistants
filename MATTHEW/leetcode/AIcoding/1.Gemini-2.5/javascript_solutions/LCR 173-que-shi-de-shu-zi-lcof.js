var rollCall = function(students) {
    const counts = {};
    for (const student of students) {
        counts[student] = (counts[student] || 0) + 1;
    }
    return counts;
};