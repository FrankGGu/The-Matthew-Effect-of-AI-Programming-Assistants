var countTriplets = function(arr) {
    let count = 0;
    for (let i = 0; i < arr.length - 1; i++) {
        for (let j = i + 1; j < arr.length; j++) {
            for (let k = j; k < arr.length; k++) {
                let a = 0;
                for (let m = i; m < j; m++) {
                    a ^= arr[m];
                }
                let b = 0;
                for (let m = j; m <= k; m++) {
                    b ^= arr[m];
                }
                if (a === b) {
                    count++;
                }
            }
        }
    }
    return count;
};