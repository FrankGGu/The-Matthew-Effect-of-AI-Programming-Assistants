var uniqueSubjects = function(teachers) {
    const teacherSubjects = new Map();

    for (const [teacher_id, subject_id, department_id] of teachers) {
        if (!teacherSubjects.has(teacher_id)) {
            teacherSubjects.set(teacher_id, new Set());
        }
        teacherSubjects.get(teacher_id).add(subject_id);
    }

    const result = [];
    for (const [teacher_id, subjectsSet] of teacherSubjects) {
        result.push([teacher_id, subjectsSet.size]);
    }

    return result;
};