var pancakeSort = function(arr) {
    let res = [];
    let n = arr.length;

    for (let size = n; size > 1; size--) {
        let maxIndex = findMaxIndex(arr, size);
        if (maxIndex !== size - 1) {
            if (maxIndex !== 0) {
                flip(arr, maxIndex);
                res.push(maxIndex + 1);
            }
            flip(arr, size - 1);
            res.push(size);
        }
    }

    return res;
};

function findMaxIndex(arr, n) {
    let maxIndex = 0;
    for (let i = 0; i < n; i++) {
        if (arr[i] > arr[maxIndex]) {
            maxIndex = i;
        }
    }
    return maxIndex;
}

function flip(arr, k) {
    let left = 0;
    let right = k;
    while (left < right) {
        [arr[left], arr[right]] = [arr[right], arr[left]];
        left++;
        right--;
    }
}