var groupThePeople = function(groupSizes) {
    const groups = {};
    const result = [];

    for (let i = 0; i < groupSizes.length; i++) {
        const size = groupSizes[i];
        if (!groups[size]) {
            groups[size] = [];
        }
        groups[size].push(i);

        if (groups[size].length === size) {
            result.push(groups[size]);
            groups[size] = [];
        }
    }

    return result;
};