var numWays = function(n, relation, k) {
    let count = 0;
    let queue = [[0, 0]];

    while (queue.length > 0) {
        let [person, steps] = queue.shift();

        if (steps === k) {
            if (person === n - 1) {
                count++;
            }
            continue;
        }

        for (let i = 0; i < relation.length; i++) {
            if (relation[i][0] === person) {
                queue.push([relation[i][1], steps + 1]);
            }
        }
    }

    return count;
};