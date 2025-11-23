var minReverseOperations = function(n, p, banned, k) {
    const bannedSet = new Set(banned);
    const result = new Array(n).fill(-1);
    result[p] = 0;

    const evenQueue = [p];
    const oddQueue = [];

    const visitedEven = new Set([p]);
    const visitedOdd = new Set();

    let evenSet = new Set();
    let oddSet = new Set();

    for (let i = 0; i < n; i++) {
        if (i % 2 === 0 && i !== p && !bannedSet.has(i)) {
            evenSet.add(i);
        } else if (i % 2 !== 0 && i !== p && !bannedSet.has(i)) {
            oddSet.add(i);
        }
    }

    let steps = 0;
    while (evenQueue.length > 0 || oddQueue.length > 0) {
        const currentQueue = steps % 2 === 0 ? evenQueue : oddQueue;
        const nextQueue = steps % 2 === 0 ? oddQueue : evenQueue;
        const visitedCurrent = steps % 2 === 0 ? visitedEven : visitedOdd;
        const visitedNext = steps % 2 === 0 ? visitedOdd : visitedEven;
        const currentSet = steps % 2 === 0 ? evenSet : oddSet;

        const queueLength = currentQueue.length;
        for (let i = 0; i < queueLength; i++) {
            const currentPosition = currentQueue.shift();
            const lowerBound = Math.max(0, currentPosition - (k - 1));
            const upperBound = Math.min(n - 1, currentPosition + (k - 1));

            let start = Math.abs((lowerBound + currentPosition) - (k - 1)) % 2 === 0 ? lowerBound : lowerBound + 1;

            for (let j = start; j <= upperBound; j += 2) {
                let target = (currentPosition - (j - currentPosition));
                if (target >= 0 && target < n && Math.abs(target - currentPosition) <= k -1 && target !== currentPosition && !bannedSet.has(target))
                 {
                    if(steps % 2 === 0 && target % 2 !== 0 && !visitedOdd.has(target)) {
                        result[target] = steps + 1;
                        visitedOdd.add(target);
                        oddQueue.push(target);
                    } else if(steps % 2 !== 0 && target % 2 === 0 && !visitedEven.has(target)) {
                         result[target] = steps + 1;
                         visitedEven.add(target);
                         evenQueue.push(target);
                    }
                }
            }

        }
        steps++;
    }

    return result;
};