var racecar = function(target) {
    let queue = [[0, 0, 1]]; // [position, steps, speed]
    let visited = new Set();

    while (queue.length > 0) {
        let [pos, steps, speed] = queue.shift();

        if (pos === target) return steps;

        let key = `${pos},${speed}`;
        if (visited.has(key)) continue;
        visited.add(key);

        // Accelerate
        queue.push([pos + speed, steps + 1, speed * 2]);

        // Reverse
        queue.push([pos, steps + 1, speed > 0 ? -1 : 1]);
    }
};