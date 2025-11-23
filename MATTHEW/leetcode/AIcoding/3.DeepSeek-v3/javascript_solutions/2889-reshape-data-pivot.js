var pivotStudents = function(students) {
    const result = [];
    const subjects = new Set();
    const studentsMap = new Map();

    for (const student of students) {
        const name = student.student;
        const subject = student.subject;
        const score = student.score;

        subjects.add(subject);

        if (!studentsMap.has(name)) {
            studentsMap.set(name, { student: name });
        }
        studentsMap.get(name)[subject] = score;
    }

    const subjectList = Array.from(subjects).sort();
    result.push(['student', ...subjectList]);

    const sortedNames = Array.from(studentsMap.keys()).sort();
    for (const name of sortedNames) {
        const row = [name];
        const studentData = studentsMap.get(name);
        for (const subject of subjectList) {
            row.push(studentData[subject] !== undefined ? studentData[subject] : null);
        }
        result.push(row);
    }

    return result;
};