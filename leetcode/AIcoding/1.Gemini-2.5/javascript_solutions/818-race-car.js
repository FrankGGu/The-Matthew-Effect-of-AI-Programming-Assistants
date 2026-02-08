var racecar = function(target) {
    // Queue stores [position, speed, steps]
    const queue = [[0, 1, 0]]; 
    // Visited set to keep track of [position, speed] states to avoid redundant computations
    // and cycles. Stored as "position,speed" strings.
    const visited = new Set();
    visited.add("0,1");

    while (queue.length > 0) {
        const [pos, speed, steps] = queue.shift();

        if (pos === target) {
            return steps;
        }

        // Option 1: Accelerate 'A'
        const nextPosA = pos + speed;
        const nextSpeedA = speed * 2;
        const stateA = `${nextPosA},${nextSpeedA}`;

        // Add to queue if this state hasn't been visited before
        if (!visited.has(stateA)) {
            visited.add(stateA);
            queue.push([nextPosA, nextSpeedA, steps + 1]);
        }

        // Option 2: Reverse 'R'
        const nextPosR = pos;
        let nextSpeedR;
        if (speed > 0) {
            nextSpeedR = -1; // Change direction to reverse (negative speed)
        } else {
            nextSpeedR = 1;  // Change direction to forward (positive speed)
        }
        const stateR = `${nextPosR},${nextSpeedR}`;

        // Add to queue if this state hasn't been visited before
        if (!visited.has(stateR)) {
            visited.add(stateR);
            queue.push([nextPosR, nextSpeedR, steps + 1]);
        }
    }

    // This part should theoretically not be reached as a path to target always exists.
    return -1; 
};