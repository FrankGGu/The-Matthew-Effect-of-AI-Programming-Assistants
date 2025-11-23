var finalValueAfterOperations = function(operations) {
    let x = 0;
    for (let i = 0; i < operations.length; i++) {
        const op = operations[i];
        if (op === "++X" || op === "X++") {
            x++;
        } else {
            x--;
        }
    }
    return x;
};