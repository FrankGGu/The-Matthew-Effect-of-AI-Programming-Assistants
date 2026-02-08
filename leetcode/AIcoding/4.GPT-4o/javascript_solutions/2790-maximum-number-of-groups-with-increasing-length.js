function maxIncreasingGroups(grades) {
    grades.sort((a, b) => a - b);
    let groupSize = 1, totalGroups = 0;

    while (grades.length >= groupSize) {
        totalGroups++;
        grades.splice(0, groupSize);
        groupSize++;
    }

    return totalGroups;
}