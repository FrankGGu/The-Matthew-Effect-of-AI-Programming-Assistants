var maxSumNonAdjacent = function(nums) {
    let incl = 0;
    let excl = 0;

    for (let num of nums) {
        let newExcl = Math.max(incl, excl);
        incl = excl + num;
        excl = newExcl;
    }

    return Math.max(incl, excl);
};