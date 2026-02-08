var countMatches = function(items, ruleKey, ruleValue) {
    let count = 0;
    let ruleIndex;

    if (ruleKey === "type") {
        ruleIndex = 0;
    } else if (ruleKey === "color") {
        ruleIndex = 1;
    } else { // ruleKey === "name"
        ruleIndex = 2;
    }

    for (let i = 0; i < items.length; i++) {
        if (items[i][ruleIndex] === ruleValue) {
            count++;
        }
    }

    return count;
};