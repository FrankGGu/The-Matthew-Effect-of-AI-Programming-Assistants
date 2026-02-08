var countInversions = function(nums) {
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

        let i = 0;
        let j = 0;
        let k = 0;
        const merged = [];

        while (i < sortedLeft.length && j < sortedRight.length) {
            if (sortedLeft[i] <= sortedRight[j]) {
                merged[k++] = sortedLeft[i++];
            } else {
                merged[k++] = sortedRight[j++];
                count += sortedLeft.length - i;
            }
        }

        while (i < sortedLeft.length) {
            merged[k++] = sortedLeft[i++];
        }

        while (j < sortedRight.length) {
            merged[k++] = sortedRight[j++];
        }

        return merged;
    }

    mergeSort(nums);
    return count;
};