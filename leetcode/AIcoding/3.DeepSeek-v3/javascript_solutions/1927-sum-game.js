var sumGame = function(num) {
    let n = num.length;
    let leftSum = 0, rightSum = 0;
    let leftQ = 0, rightQ = 0;

    for (let i = 0; i < n / 2; i++) {
        if (num[i] === '?') {
            leftQ++;
        } else {
            leftSum += parseInt(num[i]);
        }
    }

    for (let i = n / 2; i < n; i++) {
        if (num[i] === '?') {
            rightQ++;
        } else {
            rightSum += parseInt(num[i]);
        }
    }

    const totalQ = leftQ + rightQ;
    if (totalQ % 2 !== 0) {
        return true;
    }

    const aliceCanWin = (leftQ - rightQ) * 9 !== 2 * (rightSum - leftSum);
    return aliceCanWin;
};