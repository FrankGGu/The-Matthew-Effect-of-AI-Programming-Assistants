var findStudentsWhoImproved = function(students) {
    return students.filter(student => student.score2 > student.score1)
                   .map(student => student.student_id);
};