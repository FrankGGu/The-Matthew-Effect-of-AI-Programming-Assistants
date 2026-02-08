function countMatches(items, ruleKey, ruleValue) {
    const ruleMap = {
        'type': 0,
        'color': 1,
        'name': 2
    };
    const index = ruleMap[ruleKey];
    let count = 0;
    for (const item of items) {
        if (item[index] === ruleValue) {
            count++;
        }
    }
    return count;
}