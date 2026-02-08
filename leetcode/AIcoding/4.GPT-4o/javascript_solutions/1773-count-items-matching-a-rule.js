function countMatches(items, ruleKey, ruleValue) {
    let count = 0;
    const ruleIndex = ruleKey === "type" ? 0 : ruleKey === "color" ? 1 : 2;

    for (const item of items) {
        if (item[ruleIndex] === ruleValue) {
            count++;
        }
    }

    return count;
}