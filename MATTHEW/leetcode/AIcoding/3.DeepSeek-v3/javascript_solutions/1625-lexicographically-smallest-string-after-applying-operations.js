var findLexSmallestString = function(s, a, b) {
    const visited = new Set();
    let smallest = s;
    const queue = [s];
    visited.add(s);

    while (queue.length > 0) {
        const current = queue.shift();
        if (current < smallest) {
            smallest = current;
        }

        const addOp = current.split('').map((char, index) => 
            index % 2 === 1 ? String((parseInt(char) + a) % 10) : char
        ).join('');

        if (!visited.has(addOp)) {
            visited.add(addOp);
            queue.push(addOp);
        }

        const rotateOp = current.slice(-b) + current.slice(0, -b);
        if (!visited.has(rotateOp)) {
            visited.add(rotateOp);
            queue.push(rotateOp);
        }
    }

    return smallest;
};