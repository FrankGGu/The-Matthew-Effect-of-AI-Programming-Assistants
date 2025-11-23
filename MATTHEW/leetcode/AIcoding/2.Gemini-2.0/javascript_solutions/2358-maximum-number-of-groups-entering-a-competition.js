var maximumGroups = function(grades) {
    grades.sort((a, b) => a - b);
    let groups = 0;
    let currentSum = 0;
    let currentSize = 0;
    let index = 0;

    while (index < grades.length) {
        currentSum += grades[index];
        currentSize++;

        if (currentSum > (groups * (groups + 1)) / 2) {
            groups++;
            currentSum = 0;
            currentSize = 0;
        }
        index++;
    }

    return groups;
};