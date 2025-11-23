var sortArrayByParityII = function(A) {
    const res = new Array(A.length);
    let evenIndex = 0;
    let oddIndex = 1;

    for (let num of A) {
        if (num % 2 === 0) {
            res[evenIndex] = num;
            evenIndex += 2;
        } else {
            res[oddIndex] = num;
            oddIndex += 2;
        }
    }

    return res;
};