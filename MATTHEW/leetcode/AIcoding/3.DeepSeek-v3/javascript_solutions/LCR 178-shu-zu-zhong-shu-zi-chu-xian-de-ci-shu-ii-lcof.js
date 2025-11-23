var trainingPlan = function(actions) {
    let res = 0;
    for (let i = 0; i < 32; i++) {
        let count = 0;
        for (let num of actions) {
            count += (num >> i) & 1;
        }
        if (count % 3 !== 0) {
            res |= (1 << i);
        }
    }
    return res;
};