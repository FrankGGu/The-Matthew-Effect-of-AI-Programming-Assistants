function maxGroups(grades) {
    let n = 0;
    let total = 0;
    while (total + (n + 1) <= grades.length) {
        n++;
        total += n;
    }
    return n;
}