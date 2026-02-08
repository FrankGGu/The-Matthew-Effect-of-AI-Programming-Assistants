var maximumBobPoints = function(numArrows, aliceArrows) {
    let maxPoints = -1;
    let bestBob = [];

    for (let i = 0; i < (1 << 12); i++) {
        let currentBob = new Array(12).fill(0);
        let currentArrows = numArrows;
        let currentPoints = 0;

        for (let j = 0; j < 12; j++) {
            if ((i >> j) & 1) {
                let arrowsNeeded = aliceArrows[j] + 1;
                if (currentArrows >= arrowsNeeded) {
                    currentBob[j] = arrowsNeeded;
                    currentArrows -= arrowsNeeded;
                    currentPoints += j;
                } else {
                    currentPoints = -1;
                    break;
                }
            }
        }

        if (currentPoints > maxPoints) {
            maxPoints = currentPoints;
            bestBob = [...currentBob];
            bestBob[0] += currentArrows;
        }
    }

    return bestBob;
};