var buildArray = function(target, n) {
    const operations = [];
    let current = 1;
    for (let i = 0; i < target.length; i++) {
        while (current < target[i]) {
            operations.push("Push");
            operations.push("Pop");
            current++;
        }
        operations.push("Push");
        current++;
    }
    return operations;
};