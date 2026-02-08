var getCollisionTimes = function(cars) {
    const n = cars.length;
    const answer = new Array(n).fill(-1);
    const stack = []; // Stores indices of cars

    for (let i = n - 1; i >= 0; i--) {
        const [pos_i, speed_i] = cars[i];

        while (stack.length > 0) {
            const j = stack[stack.length - 1];
            const [pos_j, speed_j] = cars[j];

            if (speed_i <= speed_j) {
                stack.pop();
            } else {
                const collisionTime_ij = (pos_j - pos_i) / (speed_i - speed_j);

                if (answer[j] !== -1 && collisionTime_ij >= answer[j]) {
                    stack.pop();
                } else {
                    answer[i] = collisionTime_ij;
                    break;
                }
            }
        }
        stack.push(i);
    }

    return answer;
};