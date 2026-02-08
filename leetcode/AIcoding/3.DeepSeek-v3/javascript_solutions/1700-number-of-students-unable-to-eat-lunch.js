var countStudents = function(students, sandwiches) {
    let count = [0, 0];
    for (let s of students) {
        count[s]++;
    }
    for (let s of sandwiches) {
        if (count[s] === 0) {
            break;
        }
        count[s]--;
    }
    return count[0] + count[1];
};