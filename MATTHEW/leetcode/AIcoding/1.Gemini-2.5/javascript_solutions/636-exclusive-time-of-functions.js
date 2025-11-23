var exclusiveTime = function(n, logs) {
    const result = new Array(n).fill(0);
    const stack = []; 
    let lastTimestamp = 0;

    for (const log of logs) {
        const parts = log.split(':');
        const id = parseInt(parts[0]);
        const type = parts[1];
        const timestamp = parseInt(parts[2]);

        if (type === 'start') {
            if (stack.length > 0) {
                result[stack[stack.length - 1]] += timestamp - lastTimestamp;
            }
            stack.push(id);
            lastTimestamp = timestamp;
        } else { // type === 'end'
            result[id] += timestamp - lastTimestamp + 1;
            stack.pop();
            lastTimestamp = timestamp + 1;
        }
    }

    return result;
};