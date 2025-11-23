var closestToTarget = function(arr, target) {
    let res = Infinity;
    let sets = [];
    for (let num of arr) {
        let newSets = [num];
        for (let set of sets) {
            newSets.push(set & num);
        }
        sets = [...new Set(newSets)];
        for (let val of sets) {
            if (Math.abs(val - target) < Math.abs(res - target)) {
                res = val;
            }
        }
    }
    return res;
};