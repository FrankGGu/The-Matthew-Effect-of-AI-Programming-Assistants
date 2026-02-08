var subarrayBitwiseORs = function(arr) {
    let res = new Set();
    let cur = new Set();
    cur.add(0);
    for (let num of arr) {
        let next = new Set();
        for (let val of cur) {
            next.add(val | num);
        }
        next.add(num);
        cur = next;
        for (let val of cur) {
            res.add(val);
        }
    }
    return res.size;
};