var racecar = function(target) {
    const queue = [[0, 1, 0]]; // [position, speed, steps]
    const visited = new Set();
    visited.add("0,1");

    while (queue.length > 0) {
        const [position, speed, steps] = queue.shift();

        if (position === target) {
            return steps;
        }

        // Option 1: Accelerate
        const newPosition1 = position + speed;
        const newSpeed1 = speed * 2;
        const newState1 = `${newPosition1},${newSpeed1}`;

        if (Math.abs(newPosition1 - target) < target && !visited.has(newState1)) {
            queue.push([newPosition1, newSpeed1, steps + 1]);
            visited.add(newState1);
        }

        // Option 2: Reverse
        const newSpeed2 = speed > 0 ? -1 : 1;
        const newState2 = `${position},${newSpeed2}`;

        if (Math.abs(position - target) < target && !visited.has(newState2)) {
            queue.push([position, newSpeed2, steps + 1]);
            visited.add(newState2);
        }
    }
};