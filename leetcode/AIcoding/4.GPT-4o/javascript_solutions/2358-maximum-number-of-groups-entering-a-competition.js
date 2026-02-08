function maxGroups(grades) {
    let n = grades.length;
    let k = 0;
    while (n >= k + 1) {
        k++;
        n -= k;
    }
    return k;
}