var minimumOperations = function(nums, start, goal) {
    let queue = [[start, 0]];
    let visited = new Set();
    visited.add(start);

    while (queue.length > 0) {
        let [current, steps] = queue.shift();

        for (let num of nums) {
            let next1 = current + num;
            let next2 = current - num;
            let next3 = current ^ num;

            if (next1 === goal || next2 === goal || next3 === goal) {
                return steps + 1;
            }

            if (next1 >= 0 && next1 <= 1000 && !visited.has(next1)) {
                visited.add(next1);
                queue.push([next1, steps + 1]);
            }

            if (next2 >= 0 && next2 <= 1000 && !visited.has(next2)) {
                visited.add(next2);
                queue.push([next2, steps + 1]);
            }

            if (next3 >= 0 && next3 <= 1000 && !visited.has(next3)) {
                visited.add(next3);
                queue.push([next3, steps + 1]);
            }
        }
    }

    return -1;
};