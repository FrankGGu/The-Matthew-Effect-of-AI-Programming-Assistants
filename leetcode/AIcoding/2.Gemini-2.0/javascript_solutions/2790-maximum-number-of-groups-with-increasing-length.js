var maximumGroups = function(groups) {
    groups.sort((a, b) => a - b);
    let count = 0;
    let sum = 0;
    let currentGroupSize = 1;
    for (let i = 0; i < groups.length; i++) {
        sum += groups[i];
        if (sum >= currentGroupSize) {
            count++;
            sum = 0;
            currentGroupSize++;
        }
    }
    return count;
};