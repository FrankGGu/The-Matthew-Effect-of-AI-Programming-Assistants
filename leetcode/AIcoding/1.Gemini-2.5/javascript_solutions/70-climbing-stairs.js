var climbStairs = function(n) {
    if (n === 1) {
        return 1;
    }

    let twoStepsBefore = 1;
    let oneStepBefore = 2;

    for (let i = 3; i <= n; i++) {
        let current = oneStepBefore + twoStepsBefore;
        twoStepsBefore = oneStepBefore;
        oneStepBefore = current;
    }

    return oneStepBefore;
};