var reversePairs = function(nums) {
    let count = 0;

    function mergeSort(arr) {
        if (arr.length <= 1) {
            return arr;
        }

        const mid = Math.floor(arr.length / 2);
        const left = arr.slice(0, mid);
        const right = arr.slice(mid);

        const sortedLeft = mergeSort(left);
        const sortedRight = mergeSort(right);

        return merge(sortedLeft, sortedRight);
    }

    function merge(left, right) {
        let i = 0;
        let j = 0;
        let k = 0;
        const merged = [];

        while (i < left.length && j < right.length) {
            if (left[i] <= 2 * right[j]) {
                i++;
            } else {
                count += left.length - i;
                j++;
            }
        }

        i = 0;
        j = 0;

        while (i < left.length && j < right.length) {
            if (left[i] <= right[j]) {
                merged[k++] = left[i++];
            } else {
                merged[k++] = right[j++];
            }
        }

        while (i < left.length) {
            merged[k++] = left[i++];
        }

        while (j < right.length) {
            merged[k++] = right[j++];
        }

        return merged;
    }

    mergeSort(nums);
    return count;
};