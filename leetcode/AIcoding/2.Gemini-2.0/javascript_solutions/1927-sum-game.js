var sumGame = function(num) {
    let n = num.length;
    let leftSum = 0;
    let rightSum = 0;
    let leftQ = 0;
    let rightQ = 0;

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

    if ((leftQ + rightQ) % 2 !== 0) {
        return true;
    }

    let diffQ = leftQ - rightQ;
    let diffSum = rightSum - leftSum;

    if (diffQ / 2 * 9 === diffSum) {
        return false;
    } else {
        return true;
    }
};