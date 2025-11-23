var minCostSetTime = function(startAt, moveCost, pushCost, targetSeconds) {
    let minCost = Infinity;

    const calculateCost = (digits) => {
        let cost = 0;
        let currentPos = startAt;
        let leadingZero = true;

        for (const digit of digits) {
            if (digit === '0' && leadingZero) {
                continue;
            }
            leadingZero = false;
            if (digit - '0' !== currentPos) {
                cost += moveCost;
                currentPos = digit - '0';
            }
            cost += pushCost;
        }
        return cost;
    };

    for (let minutes = 0; minutes <= 99; minutes++) {
        const remainingSeconds = targetSeconds - minutes * 60;
        if (remainingSeconds < 0 || remainingSeconds > 99) {
            continue;
        }
        const digits = minutes.toString() + remainingSeconds.toString().padStart(2, '0');
        const cost = calculateCost(digits);
        minCost = Math.min(minCost, cost);
    }

    return minCost;
};