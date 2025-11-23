function findLexSmallestString(s, a, b) {
    const n = s.length;
    const visited = new Set();
    const queue = [s];
    let result = s;

    while (queue.length) {
        const current = queue.shift();
        if (current < result) {
            result = current;
        }
        if (visited.has(current)) continue;
        visited.add(current);

        const rotated = current.substring(n - b) + current.substring(0, n - b);
        queue.push(rotated);

        const incremented = (parseInt(current, 10) + a) % 10;
        const newStr = current.split('').map((char, index) => index % 2 === 0 ? char : incremented.toString()).join('');
        queue.push(newStr);
    }

    return result;
}