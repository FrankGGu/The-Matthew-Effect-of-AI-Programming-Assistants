var findTheDistanceValue = function(arr1, arr2, d) {
    let count = 0;
    for (let num1 of arr1) {
        let valid = true;
        for (let num2 of arr2) {
            if (Math.abs(num1 - num2) <= d) {
                valid = false;
                break;
            }
        }
        if (valid) {
            count++;
        }
    }
    return count;
};