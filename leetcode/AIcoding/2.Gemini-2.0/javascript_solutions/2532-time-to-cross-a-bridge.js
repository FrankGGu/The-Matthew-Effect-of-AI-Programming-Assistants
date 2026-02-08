var timeToCross = function(time, numWorkers, bridgeTime) {
    const left = [];
    const right = [];
    for (let i = 0; i < time.length; i++) {
        left.push(time[i]);
    }

    left.sort((a, b) => (a[0] + a[1]) - (b[0] + b[1]));

    let currentTime = 0;
    let waitingLeft = [];
    let waitingRight = [];
    let onBridge = null;

    while (left.length > 0 || right.length > 0 || waitingLeft.length > 0 || waitingRight.length > 0 || onBridge !== null) {
        while (waitingRight.length > 0 && (left.length === 0 && waitingLeft.length === 0 && onBridge === null)) {
            const worker = waitingRight.shift();
            onBridge = { worker, direction: 'left', finishTime: currentTime + time[worker][2] };
        }
        while (waitingLeft.length > 0 && waitingRight.length < numWorkers) {
            const worker = waitingLeft.shift();
            onBridge = { worker, direction: 'right', finishTime: currentTime + time[worker][0] };
        }

        while (left.length > 0 && waitingLeft.length < numWorkers) {
            waitingLeft.push(left.shift().indexOf(Math.min(...left[0])) >= 0 ? 0 : left.length > 0 ? 1 : 0);
            waitingLeft.sort((a, b) => (time[a][0]) - (time[b][0]));
        }

        if (onBridge !== null && onBridge.finishTime <= currentTime) {
            if (onBridge.direction === 'right') {
                waitingRight.push(onBridge.worker);
                waitingRight.sort((a, b) => (time[a][2]) - (time[b][2]));
            } else {
                waitingLeft.push(onBridge.worker);
                waitingLeft.sort((a, b) => (time[a][0]) - (time[b][0]));
            }
            onBridge = null;
        }

        if (onBridge === null) {
            if (waitingRight.length > 0 && (left.length === 0 && waitingLeft.length === 0)) {
                const worker = waitingRight.shift();
                onBridge = { worker, direction: 'left', finishTime: currentTime + time[worker][2] };
            } else if (waitingLeft.length > 0 && waitingRight.length < numWorkers) {
                const worker = waitingLeft.shift();
                onBridge = { worker, direction: 'right', finishTime: currentTime + time[worker][0] };
            } else {
                if (onBridge === null && waitingLeft.length === 0 && waitingRight.length === 0 && left.length > 0 && right.length > 0) {
                     currentTime = Math.min(onBridge?.finishTime ?? Infinity, 10000)
                } else if (onBridge === null && waitingLeft.length === 0 && waitingRight.length === 0 && left.length > 0) {
                      currentTime = Math.min(onBridge?.finishTime ?? Infinity, 10000)
                } else if (onBridge === null && waitingLeft.length === 0 && waitingRight.length === 0) {
                     currentTime = Math.min(onBridge?.finishTime ?? Infinity, 10000)
                }
            }
        }

        if(onBridge !== null) {
            currentTime = Math.max(currentTime, onBridge.finishTime);
        } else {
            currentTime++;
        }
    }

    return currentTime;
};