var countStudents = function(students, sandwiches) {
    let i = 0;
    while (students.length > 0) {
        if (students[0] === sandwiches[0]) {
            students.shift();
            sandwiches.shift();
            i = 0;
        } else {
            students.push(students.shift());
            i++;
        }
        if (i === students.length) {
            break;
        }
    }
    return students.length;
};