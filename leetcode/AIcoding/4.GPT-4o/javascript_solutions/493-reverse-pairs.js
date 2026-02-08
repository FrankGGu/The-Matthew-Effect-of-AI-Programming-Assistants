var reversePairs = function(nums) {
    let count = 0;

    const mergeSort = (arr) => {
        if (arr.length < 2) return arr;
        const mid = Math.floor(arr.length / 2);
        const left = mergeSort(arr.slice(0, mid));
        const right = mergeSort(arr.slice(mid));
        let j = 0;

        for (let i = 0; i < left.length; i++) {
            while (j < right.length && left[i] > 2 * right[j]) {
                j++;
            }
            count += j;
        }

        return merge(left, right);
    };

    const merge = (left, right) => {
        const merged = [];
        let i = 0, j = 0;

        while (i < left.length && j < right.length) {
            if (left[i] <= right[j]) {
                merged.push(left[i]);
                i++;
            } else {
                merged.push(right[j]);
                j++;
            }
        }

        return merged.concat(left.slice(i)).concat(right.slice(j));
    };

    mergeSort(nums);
    return count;
};