var calPoints = function(operations) {
    let record = [];
    for (let i = 0; i < operations.length; i++) {
        const op = operations[i];
        if (op === "+") {
            const sum = record[record.length - 1] + record[record.length - 2];
            record.push(sum);
        } else if (op === "D") {
            const doubled = record[record.length - 1] * 2;
            record.push(doubled);
        } else if (op === "C") {
            record.pop();
        } else {
            record.push(parseInt(op));
        }
    }

    let totalSum = 0;
    for (let i = 0; i < record.length; i++) {
        totalSum += record[i];
    }
    return totalSum;
};