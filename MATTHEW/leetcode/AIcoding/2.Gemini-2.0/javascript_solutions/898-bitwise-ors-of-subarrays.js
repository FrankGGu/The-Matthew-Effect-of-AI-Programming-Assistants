var subarrayBitwiseORs = function(arr) {
    let ans = new Set();
    let current = new Set();

    for (let x of arr) {
        let next = new Set();
        next.add(x);
        for (let y of current) {
            next.add(x | y);
        }
        for (let y of next) {
            ans.add(y);
        }
        current = next;
    }

    return ans.size;
};