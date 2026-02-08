var relativeSortArray = function(arr1, arr2) {
    const frequency = new Array(1001).fill(0);
    const result = [];

    for (const num of arr1) {
        frequency[num]++;
    }

    for (const num of arr2) {
        while (frequency[num] > 0) {
            result.push(num);
            frequency[num]--;
        }
    }

    for (let i = 0; i <= 1000; i++) {
        while (frequency[i] > 0) {
            result.push(i);
            frequency[i]--;
        }
    }

    return result;
};