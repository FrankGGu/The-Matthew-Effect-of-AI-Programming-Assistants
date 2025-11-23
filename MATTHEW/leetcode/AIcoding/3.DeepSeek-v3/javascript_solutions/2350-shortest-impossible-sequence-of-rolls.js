var shortestSequence = function(rolls, k) {
    let res = 1;
    let set = new Set();
    for (let num of rolls) {
        set.add(num);
        if (set.size === k) {
            res++;
            set.clear();
        }
    }
    return res;
};