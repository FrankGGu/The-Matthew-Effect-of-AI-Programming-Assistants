var countStudents = function(students, sandwiches) {
    let counts = [0, 0]; // counts[0] for students wanting 0, counts[1] for students wanting 1

    for (let student of students) {
        counts[student]++;
    }

    for (let sandwich of sandwiches) {
        if (counts[sandwich] > 0) {
            counts[sandwich]--;
        } else {
            return counts[0] + counts[1];
        }
    }

    return 0;
};