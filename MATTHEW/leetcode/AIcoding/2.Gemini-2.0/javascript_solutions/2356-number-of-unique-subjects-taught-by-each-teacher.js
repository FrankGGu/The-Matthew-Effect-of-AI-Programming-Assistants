var numberOfUniqueSubjects = function(teachers) {
    const teacherSubjects = {};

    for (const [teacherId, subjectId] of teachers) {
        if (!teacherSubjects[teacherId]) {
            teacherSubjects[teacherId] = new Set();
        }
        teacherSubjects[teacherId].add(subjectId);
    }

    const result = [];
    for (const teacherId in teacherSubjects) {
        result.push([teacherId, teacherSubjects[teacherId].size.toString()]);
    }

    return result;
};