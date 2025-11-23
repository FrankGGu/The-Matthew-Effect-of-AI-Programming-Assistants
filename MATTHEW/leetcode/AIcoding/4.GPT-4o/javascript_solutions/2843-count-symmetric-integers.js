var symmetricIntegers = function(low, high) {
    let count = 0;
    for (let i = low; i <= high; i++) {
        let str = i.toString();
        let leftSum = 0, rightSum = 0;
        for (let j = 0; j < str.length; j++) {
            if (j < str.length / 2) {
                leftSum += Number(str[j]);
            } else {
                rightSum += Number(str[j]);
            }
        }
        if (leftSum === rightSum) {
            count++;
        }
    }
    return count;
};