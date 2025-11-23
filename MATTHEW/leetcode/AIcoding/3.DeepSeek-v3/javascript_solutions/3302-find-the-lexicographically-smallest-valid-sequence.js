var findLexSmallestString = function(s, a, b) {
    let visited = new Set();
    let queue = [s];
    let min = s;

    while (queue.length > 0) {
        let current = queue.shift();
        if (current < min) {
            min = current;
        }

        // Operation 1: Add a to odd indices
        let op1 = current.split('');
        for (let i = 1; i < op1.length; i += 2) {
            let num = parseInt(op1[i]);
            num = (num + a) % 10;
            op1[i] = num.toString();
        }
        let op1Str = op1.join('');
        if (!visited.has(op1Str)) {
            visited.add(op1Str);
            queue.push(op1Str);
        }

        // Operation 2: Rotate right by b positions
        let op2 = current.slice(-b) + current.slice(0, -b);
        if (!visited.has(op2)) {
            visited.add(op2);
            queue.push(op2);
        }
    }

    return min;
};