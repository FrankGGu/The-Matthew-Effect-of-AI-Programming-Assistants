var relativeSortArray = function(arr1, arr2) {
    const count = new Array(1001).fill(0);
    const result = [];

    for (const num of arr1) {
        count[num]++;
    }

    for (const num of arr2) {
        while (count[num] > 0) {
            result.push(num);
            count[num]--;
        }
    }

    for (let i = 0; i < count.length; i++) {
        while (count[i] > 0) {
            result.push(i);
            count[i]--;
        }
    }

    return result;
};