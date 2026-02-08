var findCrossingTime = function(n, k, time) {
    time.sort((a, b) => {
        if (a[0] + a[2] !== b[0] + b[2]) {
            return (a[0] + a[2]) - (b[0] + b[2]);
        } else {
            return a[4] - b[4];
        }
    });

    let leftBank = new Array(k);
    for (let i = 0; i < k; i++) {
        leftBank[i] = i;
    }
    leftBank.sort((a, b) => b - a);

    let rightBank = [];
    let leftWaitQueue = [];
    let rightWaitQueue = [];

    let currentTime = 0;
    let leftToRight = true;
    let remainingBoxes = n;

    while (remainingBoxes > 0 || rightBank.length > 0 || rightWaitQueue.length > 0) {
        while (leftWaitQueue.length > 0 && leftWaitQueue[0][0] <= currentTime) {
            const [_, worker] = leftWaitQueue.shift();
            leftBank.push(worker);
            leftBank.sort((a, b) => b - a);
        }

        while (rightWaitQueue.length > 0 && rightWaitQueue[0][0] <= currentTime) {
            const [_, worker] = rightWaitQueue.shift();
            rightBank.push(worker);
            rightBank.sort((a, b) => b - a);
        }

        if (leftToRight) {
            if (leftBank.length > 0 && remainingBoxes > 0) {
                const worker = leftBank.shift();
                const [leftToRightTime, _, rightToLeftTime, _, _] = time[worker];
                const finishTime = currentTime + leftToRightTime;
                rightWaitQueue.push([finishTime, worker]);
                rightWaitQueue.sort((a, b) => a[0] - b[0]);
                remainingBoxes--;
                leftToRight = false;
            } else if (rightBank.length > 0) {
                leftToRight = false;
            } else {
                let nextEvent = Infinity;
                if (leftWaitQueue.length > 0) nextEvent = Math.min(nextEvent, leftWaitQueue[0][0]);
                if (rightWaitQueue.length > 0) nextEvent = Math.min(nextEvent, rightWaitQueue[0][0]);
                currentTime = nextEvent;
            }
        } else {
            if (rightBank.length > 0) {
                const worker = rightBank.shift();
                const [leftToRightTime, _, rightToLeftTime, _, _] = time[worker];
                const finishTime = currentTime + rightToLeftTime;
                leftWaitQueue.push([finishTime, worker]);
                leftWaitQueue.sort((a, b) => a[0] - b[0]);
                leftToRight = true;
            } else if (leftBank.length > 0 && remainingBoxes > 0) {
                leftToRight = true;
            } else {
                let nextEvent = Infinity;
                if (leftWaitQueue.length > 0) nextEvent = Math.min(nextEvent, leftWaitQueue[0][0]);
                if (rightWaitQueue.length > 0) nextEvent = Math.min(nextEvent, rightWaitQueue[0][0]);
                currentTime = nextEvent;
            }
        }

        if (leftBank.length === 0 && rightBank.length === 0) {
            let nextEvent = Infinity;
            if (leftWaitQueue.length > 0) nextEvent = Math.min(nextEvent, leftWaitQueue[0][0]);
            if (rightWaitQueue.length > 0) nextEvent = Math.min(nextEvent, rightWaitQueue[0][0]);
            currentTime = nextEvent;
        }
    }

    while (leftWaitQueue.length > 0) {
        const [finishTime, _] = leftWaitQueue.shift();
        currentTime = Math.max(currentTime, finishTime);
    }

    return currentTime;
};