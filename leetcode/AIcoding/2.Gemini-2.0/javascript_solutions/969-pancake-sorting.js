var pancakeSort = function(arr) {
    const n = arr.length;
    const result = [];

    for (let i = n; i > 0; i--) {
        let maxIndex = 0;
        for (let j = 1; j < i; j++) {
            if (arr[j] > arr[maxIndex]) {
                maxIndex = j;
            }
        }

        if (maxIndex !== i - 1) {
            if (maxIndex !== 0) {
                result.push(maxIndex + 1);
                arr = flip(arr, maxIndex + 1);
            }

            result.push(i);
            arr = flip(arr, i);
        }
    }

    return result;

    function flip(arr, k) {
        let left = 0;
        let right = k - 1;
        while (left < right) {
            [arr[left], arr[right]] = [arr[right], arr[left]];
            left++;
            right--;
        }
        return arr;
    }
};