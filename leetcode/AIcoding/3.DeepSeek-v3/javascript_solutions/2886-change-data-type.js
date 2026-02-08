var changeType = function(students) {
    return students.map(student => ({
        ...student,
        age: String(student.age),
        grade: String(student.grade)
    }));
};