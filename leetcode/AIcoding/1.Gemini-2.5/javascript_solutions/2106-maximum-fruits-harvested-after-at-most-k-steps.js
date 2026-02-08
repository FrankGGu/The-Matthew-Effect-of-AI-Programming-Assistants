var maxTotalFruits = function(fruits, startPos, k) {
    let maxFruits = 0;
    let currentFruits = 0;
    let left = 0;
    const n = fruits.length;

    for (let right = 0; right < n; right++) {
        currentFruits += fruits[right][1];
        let rightPos = fruits[right][0];

        while (left <= right) {
            let leftPos = fruits[left][0];
            let steps = 0;

            if (rightPos < startPos) {
                steps = startPos - leftPos;
            } else if (leftPos > startPos) {
                steps = rightPos - startPos;
            } else { // leftPos <= startPos <= rightPos
                let stepsA = (startPos - leftPos) + (rightPos - leftPos);
                let stepsB = (rightPos - startPos) + (rightPos - leftPos);
                steps = Math.min(stepsA, stepsB);
            }

            if (steps <= k) {
                maxFruits = Math.max(maxFruits, currentFruits);
                break;
            } else {
                currentFruits -= fruits[left][1];
                left++;
            }
        }
    }

    return maxFruits;
};