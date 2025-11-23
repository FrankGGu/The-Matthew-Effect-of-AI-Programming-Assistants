var minimumOperations = function(nums, start, goal) {
    let queue = [[start, 0]];
    let visited = new Set();
    visited.add(start);

    while (queue.length > 0) {
        let [curr, steps] = queue.shift();

        if (curr === goal) {
            return steps;
        }

        for (let num of nums) {
            let next1 = curr + num;
            let next2 = curr - num;
            let next3 = curr ^ num;

            if (next1 >= 0 && next1 <= 1000 && !visited.has(next1)) {
                queue.push([next1, steps + 1]);
                visited.add(next1);
            }
            if (next2 >= 0 && next2 <= 1000 && !visited.has(next2)) {
                queue.push([next2, steps + 1]);
                visited.add(next2);
            }
            if (next3 >= 0 && next3 <= 1000 && !visited.has(next3)) {
                queue.push([next3, steps + 1]);
                visited.add(next3);
            }
        }
    }

    return -1;
};