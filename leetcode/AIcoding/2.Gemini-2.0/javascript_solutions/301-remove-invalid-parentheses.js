var removeInvalidParentheses = function(s) {
    const isValid = (str) => {
        let count = 0;
        for (let char of str) {
            if (char === '(') {
                count++;
            } else if (char === ')') {
                count--;
            }
            if (count < 0) {
                return false;
            }
        }
        return count === 0;
    };

    const queue = new Set([s]);
    const visited = new Set([s]);
    const result = [];
    let found = false;

    while (queue.size > 0) {
        const currentQueue = Array.from(queue);
        queue.clear();

        for (const str of currentQueue) {
            if (isValid(str)) {
                result.push(str);
                found = true;
            }
        }

        if (found) {
            break;
        }

        for (const str of currentQueue) {
            for (let i = 0; i < str.length; i++) {
                if (str[i] === '(' || str[i] === ')') {
                    const nextStr = str.substring(0, i) + str.substring(i + 1);
                    if (!visited.has(nextStr)) {
                        queue.add(nextStr);
                        visited.add(nextStr);
                    }
                }
            }
        }
    }

    return result;
};