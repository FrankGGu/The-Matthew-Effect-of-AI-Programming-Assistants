function topKStudents(students, k) {
    return students.sort((a, b) => b[1] - a[1]).slice(0, k).map(student => student[0]);
}