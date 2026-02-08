var findMinStep = function(board, hand) {
    const balls = board.split('');
    const handBalls = hand.split('');
    const handMap = new Map();
    for (const ball of handBalls) {
        handMap.set(ball, (handMap.get(ball) || 0) + 1);
    }

    let queue = [[balls, handMap, 0]];
    let visited = new Set();
    visited.add(balls.join(''));

    while (queue.length > 0) {
        const [currBalls, currHand, steps] = queue.shift();

        if (currBalls.length === 0) {
            return steps;
        }

        for (let i = 0; i <= currBalls.length; i++) {
            for (const [color, count] of currHand) {
                if (count > 0) {
                    let nextBalls = [...currBalls];
                    nextBalls.splice(i, 0, color);
                    let stabilizedBalls = stabilize(nextBalls);

                    if (stabilizedBalls.length === 0) {
                        return steps + 1;
                    }

                    let nextHand = new Map(currHand);
                    nextHand.set(color, count - 1);

                    const nextBoardStr = stabilizedBalls.join('');
                    if (!visited.has(nextBoardStr)) {
                        visited.add(nextBoardStr);
                        queue.push([stabilizedBalls, nextHand, steps + 1]);
                    }
                }
            }
        }
    }

    return -1;

    function stabilize(balls) {
        let stabilized = [...balls];
        let changed = true;

        while (changed) {
            changed = false;
            let i = 0;
            while (i < stabilized.length) {
                let j = i;
                while (j < stabilized.length && stabilized[i] === stabilized[j]) {
                    j++;
                }
                if (j - i >= 3) {
                    stabilized.splice(i, j - i);
                    changed = true;
                } else {
                    i = j;
                }
            }
        }
        return stabilized;
    }
};