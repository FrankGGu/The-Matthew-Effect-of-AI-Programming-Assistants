var getCollisionTimes = function(cars) {
    const n = cars.length;
    const result = new Array(n).fill(-1);
    const stack = [];

    for (let i = n - 1; i >= 0; i--) {
        const [speed, position] = [cars[i][0], cars[i][1]];

        while (stack.length > 0) {
            const j = stack[stack.length - 1];
            const [otherSpeed, otherPosition] = [cars[j][0], cars[j][1]];

            if (speed <= otherSpeed) {
                stack.pop();
            } else {
                const time = (otherPosition - position) / (speed - otherSpeed);
                if (result[j] === -1 || time <= result[j]) {
                    result[i] = time;
                    break;
                } else {
                    stack.pop();
                }
            }
        }

        stack.push(i);
    }

    return result;
};