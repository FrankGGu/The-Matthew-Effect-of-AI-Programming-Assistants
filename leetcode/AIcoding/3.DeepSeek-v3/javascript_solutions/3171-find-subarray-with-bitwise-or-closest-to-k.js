var closestToTarget = function(arr, target) {
    let res = Infinity;
    let ors = new Set();
    for (let num of arr) {
        let temp = new Set();
        temp.add(num);
        for (let val of ors) {
            temp.add(val | num);
        }
        for (let val of temp) {
            res = Math.min(res, Math.abs(val - target));
        }
        ors = temp;
    }
    return res;
};