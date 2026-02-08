var findLexSmallestString = function(s, a, b) {
    let minString = s;
    const n = s.length;

    const queue = [s];
    const visited = new Set([s]);

    while (queue.length > 0) {
        const currentString = queue.shift();

        // Update minString if currentString is lexicographically smaller
        if (currentString < minString) {
            minString = currentString;
        }

        // Operation 1: Add a to all odd-indexed digits
        let arr1 = currentString.split('');
        for (let i = 1; i < n; i += 2) {
            arr1[i] = String((parseInt(arr1[i]) + a) % 10);
        }
        const nextString1 = arr1.join('');

        if (!visited.has(nextString1)) {
            visited.add(nextString1);
            queue.push(nextString1);
        }

        // Operation 2: Rotate s to the left by b positions (as per example s.substring(b) + s.substring(0, b))
        const nextString2 = currentString.substring(b) + currentString.substring(0, b);

        if (!visited.has(nextString2)) {
            visited.add(nextString2);
            queue.push(nextString2);
        }
    }

    return minString;
};