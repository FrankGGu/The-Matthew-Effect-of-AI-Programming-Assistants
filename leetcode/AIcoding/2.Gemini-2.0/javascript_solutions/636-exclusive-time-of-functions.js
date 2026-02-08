var exclusiveTime = function(n, logs) {
    const result = new Array(n).fill(0);
    const stack = [];
    let prevTime = 0;

    for (const log of logs) {
        const [funcId, type, time] = log.split(':');
        const id = parseInt(funcId);
        const timestamp = parseInt(time);

        if (type === 'start') {
            if (stack.length > 0) {
                result[stack[stack.length - 1]] += timestamp - prevTime;
            }
            stack.push(id);
            prevTime = timestamp;
        } else {
            result[id] += timestamp - prevTime + 1;
            prevTime = timestamp + 1;
            stack.pop();
        }
    }

    return result;
};