function isSumGame(s) {
    let leftSum = 0, rightSum = 0, leftCount = 0, rightCount = 0;
    const n = s.length;

    for (let i = 0; i < n; i++) {
        if (i < n / 2) {
            if (s[i] === '?') leftCount++;
            else leftSum += Number(s[i]);
        } else {
            if (s[i] === '?') rightCount++;
            else rightSum += Number(s[i]);
        }
    }

    const leftPossible = new Set();
    for (let i = 0; i <= leftCount; i++) {
        leftPossible.add(leftSum + i * 9);
    }

    const rightPossible = new Set();
    for (let i = 0; i <= rightCount; i++) {
        rightPossible.add(rightSum + i * 9);
    }

    for (let left of leftPossible) {
        if (rightPossible.has(left)) {
            return false;
        }
    }

    return true;
}