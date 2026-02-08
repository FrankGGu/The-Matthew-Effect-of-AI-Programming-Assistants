var findLexSmallestString = function(s, a, b) {
    let visited = new Set();
    let queue = [s];
    let smallest = s;

    while (queue.length > 0) {
        let current = queue.shift();
        if (visited.has(current)) continue;
        visited.add(current);
        if (current < smallest) {
            smallest = current;
        }

        let op1 = current.split('');
        for (let i = 1; i < op1.length; i += 2) {
            op1[i] = String.fromCharCode(((op1[i].charCodeAt(0) - '0'.charCodeAt(0) + a) % 10 + '0'.charCodeAt(0));
        }
        let newStr1 = op1.join('');
        if (!visited.has(newStr1)) {
            queue.push(newStr1);
        }

        let newStr2 = current.slice(b) + current.slice(0, b);
        if (!visited.has(newStr2)) {
            queue.push(newStr2);
        }
    }

    return smallest;
};