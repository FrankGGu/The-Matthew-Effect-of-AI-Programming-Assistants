var beautifulArray = function(n) {
    let res = [1];
    while (res.length < n) {
        let temp = [];
        for (let num of res) {
            if (num * 2 - 1 <= n) {
                temp.push(num * 2 - 1);
            }
        }
        for (let num of res) {
            if (num * 2 <= n) {
                temp.push(num * 2);
            }
        }
        res = temp;
    }
    return res;
};