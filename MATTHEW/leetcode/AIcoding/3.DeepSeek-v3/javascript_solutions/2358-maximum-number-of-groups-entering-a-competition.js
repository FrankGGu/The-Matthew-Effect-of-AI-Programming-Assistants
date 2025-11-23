var maximumGroups = function(grades) {
    let k = 0;
    let total = 0;
    const n = grades.length;
    while (total + k + 1 <= n) {
        k++;
        total += k;
    }
    return k;
};