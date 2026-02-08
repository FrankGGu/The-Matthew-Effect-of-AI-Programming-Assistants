var removeInvalidParentheses = function(s) {
    const isValid = (str) => {
        let balance = 0;
        for (let char of str) {
            if (char === '(') {
                balance++;
            } else if (char === ')') {
                balance--;
            }
            if (balance < 0) {
                return false;
            }
        }
        return balance === 0;
    };

    const result = [];
    const queue = [s];
    const visited = new Set();
    visited.add(s);
    let found = false;

    while (queue.length > 0) {
        const currentString = queue.shift();

        if (isValid(currentString)) {
            result.push(currentString);
            found = true;
        }

        if (found) {
            continue;
        }

        for (let i = 0; i < currentString.length; i++) {
            const char = currentString[i];
            if (char === '(' || char === ')') {
                const nextString = currentString.substring(0, i) + currentString.substring(i + 1);
                if (!visited.has(nextString)) {
                    visited.add(nextString);
                    queue.push(nextString);
                }
            }
        }
    }

    return result;
};