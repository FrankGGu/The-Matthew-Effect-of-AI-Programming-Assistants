var countMatches = function(items, ruleKey, ruleValue) {
    let count = 0;
    let index;
    if (ruleKey === "type") {
        index = 0;
    } else if (ruleKey === "color") {
        index = 1;
    } else {
        index = 2;
    }
    for (const item of items) {
        if (item[index] === ruleValue) {
            count++;
        }
    }
    return count;
};