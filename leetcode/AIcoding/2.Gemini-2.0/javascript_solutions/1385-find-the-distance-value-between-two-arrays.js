var findTheDistanceValue = function(arr1, arr2, d) {
    let count = 0;
    for (let i = 0; i < arr1.length; i++) {
        let found = false;
        for (let j = 0; j < arr2.length; j++) {
            if (Math.abs(arr1[i] - arr2[j]) <= d) {
                found = true;
                break;
            }
        }
        if (!found) {
            count++;
        }
    }
    return count;
};