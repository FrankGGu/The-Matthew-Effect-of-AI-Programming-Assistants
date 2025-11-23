function exclusiveTime(n, logs) {
    const result = new Array(n).fill(0);
    const stack = [];
    let prevTime = 0;

    for (const log of logs) {
        const [id, type, time] = log.split(':');
        const functionId = parseInt(id);
        const currentTime = parseInt(time);

        if (type === 'start') {
            if (stack.length > 0) {
                result[stack[stack.length - 1]] += currentTime - prevTime;
            }
            stack.push(functionId);
            prevTime = currentTime;
        } else {
            result[stack.pop()] += currentTime - prevTime + 1;
            prevTime = currentTime + 1;
        }
    }

    return result;
}