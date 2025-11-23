function findStudents(students, sandwiches) {
    const count = [0, 0];
    for (const student of students) {
        count[student]++;
    }

    let i = 0;
    while (i < sandwiches.length && count[sandwiches[i]] > 0) {
        count[sandwiches[i]]--;
        i++;
    }

    return count[0] + count[1];
}