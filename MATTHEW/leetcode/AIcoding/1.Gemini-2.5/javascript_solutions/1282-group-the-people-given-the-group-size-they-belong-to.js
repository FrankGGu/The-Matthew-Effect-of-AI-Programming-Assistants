var groupThePeople = function(groupSizes) {
    const result = [];
    const groupsMap = {};

    for (let i = 0; i < groupSizes.length; i++) {
        const size = groupSizes[i];

        if (!groupsMap[size]) {
            groupsMap[size] = [];
        }

        groupsMap[size].push(i);

        if (groupsMap[size].length === size) {
            result.push(groupsMap[size]);
            groupsMap[size] = [];
        }
    }

    return result;
};