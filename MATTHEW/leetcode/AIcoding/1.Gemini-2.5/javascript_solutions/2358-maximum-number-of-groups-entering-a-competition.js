var maximumGroups = function(grades) {
    let n = grades.length;
    let k = 0;
    let studentsUsed = 0;
    while (studentsUsed + (k + 1) <= n) {
        k++;
        studentsUsed += k;
    }
    return k;
};