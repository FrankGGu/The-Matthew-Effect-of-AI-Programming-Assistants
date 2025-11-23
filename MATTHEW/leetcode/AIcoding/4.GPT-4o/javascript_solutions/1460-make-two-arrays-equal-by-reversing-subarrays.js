var canBeEqual = function(target, arr) {
    if (target.length !== arr.length) return false;
    const count = {};

    for (let num of target) {
        count[num] = (count[num] || 0) + 1;
    }

    for (let num of arr) {
        if (!count[num]) return false;
        count[num]--;
    }

    return true;
};