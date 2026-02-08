function lexSmallestString(s, a, b) {
    const n = s.length;
    const visited = new Set();
    const queue = [s];
    let result = s;

    while (queue.length) {
        const curr = queue.shift();
        if (curr < result) {
            result = curr;
        }

        if (!visited.has(curr)) {
            visited.add(curr);

            const rotated = curr.slice(-b) + curr.slice(0, -b);
            if (!visited.has(rotated)) {
                queue.push(rotated);
            }

            let incremented = '';
            for (let char of curr) {
                incremented += String.fromCharCode(((char.charCodeAt(0) - 'a'.charCodeAt(0) + a) % 26) + 'a'.charCodeAt(0));
            }
            if (!visited.has(incremented)) {
                queue.push(incremented);
            }
        }
    }

    return result;
}