var removeInvalidParentheses = function(s) {
    const isValid = (str) => {
        let count = 0;
        for (const char of str) {
            if (char === '(') count++;
            else if (char === ')') count--;
            if (count < 0) return false;
        }
        return count === 0;
    };

    const bfs = (start) => {
        const queue = [start];
        const visited = new Set();
        const results = [];
        let found = false;

        while (queue.length) {
            const curr = queue.shift();
            if (isValid(curr)) {
                results.push(curr);
                found = true;
            }
            if (found) continue;

            for (let i = 0; i < curr.length; i++) {
                if (curr[i] !== '(' && curr[i] !== ')') continue;
                const next = curr.slice(0, i) + curr.slice(i + 1);
                if (!visited.has(next)) {
                    visited.add(next);
                    queue.push(next);
                }
            }
        }
        return results;
    };

    return bfs(s);
};