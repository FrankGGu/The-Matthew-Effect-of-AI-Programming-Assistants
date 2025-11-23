var countStudents = function(students, sandwiches) {
    let count = [0, 0];
    for (let student of students) {
        count[student]++;
    }

    for (let sandwich of sandwiches) {
        if (count[sandwich] === 0) break;
        count[sandwich]--;
    }

    return count[0] + count[1];
};