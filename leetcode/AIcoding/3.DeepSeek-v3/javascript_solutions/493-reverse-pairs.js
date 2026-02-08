var reversePairs = function(nums) {
    let count = 0;

    function mergeSort(arr) {
        if (arr.length <= 1) return arr;
        const mid = Math.floor(arr.length / 2);
        const left = mergeSort(arr.slice(0, mid));
        const right = mergeSort(arr.slice(mid));
        return merge(left, right);
    }

    function merge(left, right) {
        let i = 0, j = 0;
        while (i < left.length && j < right.length) {
            if (left[i] > 2 * right[j]) {
                count += left.length - i;
                j++;
            } else {
                i++;
            }
        }

        let merged = [];
        i = 0, j = 0;
        while (i < left.length && j < right.length) {
            if (left[i] < right[j]) {
                merged.push(left[i]);
                i++;
            } else {
                merged.push(right[j]);
                j++;
            }
        }
        merged = merged.concat(left.slice(i)).concat(right.slice(j));
        return merged;
    }

    mergeSort(nums);
    return count;
};