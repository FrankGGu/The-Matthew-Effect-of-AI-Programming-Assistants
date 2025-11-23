function happyStudents(students) {
    let happyCount = 0;
    for (let i = 0; i < students.length; i++) {
        if (students[i] === 1) {
            happyCount++;
        }
    }
    return happyCount;
}