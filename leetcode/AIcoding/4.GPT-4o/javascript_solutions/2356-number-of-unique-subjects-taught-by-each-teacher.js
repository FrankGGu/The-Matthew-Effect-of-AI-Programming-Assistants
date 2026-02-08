var numOfUniqueSubjects = function(teachers) {
    const uniqueSubjectsCount = [];
    for (const subjects of teachers) {
        const uniqueSubjects = new Set(subjects);
        uniqueSubjectsCount.push(uniqueSubjects.size);
    }
    return uniqueSubjectsCount;
};