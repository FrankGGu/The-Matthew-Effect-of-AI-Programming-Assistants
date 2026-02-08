var buildArray = function(target, n) {
    const operations = [];
    let targetIdx = 0;

    for (let i = 1; i <= n; i++) {
        if (targetIdx === target.length) {
            break;
        }

        if (i === target[targetIdx]) {
            operations.push("Push");
            targetIdx++;
        } else {
            operations.push("Push");
            operations.push("Pop");
        }
    }

    return operations;
};