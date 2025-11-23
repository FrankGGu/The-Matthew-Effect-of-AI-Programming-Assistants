var recommendedPairs = function(categories) {
    const pairCount = {};

    for (const [user, category] of categories) {
        if (!pairCount[category]) {
            pairCount[category] = new Set();
        }
        pairCount[category].add(user);
    }

    const result = [];
    const categoryList = Object.keys(pairCount);

    for (let i = 0; i < categoryList.length; i++) {
        for (let j = i + 1; j < categoryList.length; j++) {
            const categoryA = categoryList[i];
            const categoryB = categoryList[j];
            const commonUsers = [...pairCount[categoryA]].filter(user => pairCount[categoryB].has(user)).length;
            if (commonUsers > 0) {
                result.push([categoryA, categoryB]);
            }
        }
    }

    return result;
};