var createDataframe = function(column, columnName) {
    return function(students) {
        students.forEach(student => {
            student[columnName] = column(student);
        });
        return students;
    }
};