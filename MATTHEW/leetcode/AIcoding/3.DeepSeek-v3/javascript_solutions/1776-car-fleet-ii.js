var getCollisionTimes = function(cars) {
    const n = cars.length;
    const stack = [];
    const res = new Array(n).fill(-1);

    for (let i = n - 1; i >= 0; i--) {
        const [pos, speed] = cars[i];
        while (stack.length > 0) {
            const top = stack[stack.length - 1];
            const [topPos, topSpeed, topTime] = cars[top];
            if (speed <= topSpeed) {
                stack.pop();
            } else {
                const time = (topPos - pos) / (speed - topSpeed);
                if (time <= topTime || topTime === -1) {
                    res[i] = time;
                    break;
                } else {
                    stack.pop();
                }
            }
        }
        stack.push(i);
    }

    return res;
};