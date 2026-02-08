var countSmaller = function(nums) {
    const result = new Array(nums.length).fill(0);
    const indexedNums = nums.map((num, index) => ({ num, index }));

    const mergeSort = (arr) => {
        if (arr.length <= 1) return arr;
        const mid = Math.floor(arr.length / 2);
        const left = mergeSort(arr.slice(0, mid));
        const right = mergeSort(arr.slice(mid));
        return merge(left, right);
    };

    const merge = (left, right) => {
        const merged = [];
        let i = 0, j = 0;
        let rightCount = 0;

        while (i < left.length && j < right.length) {
            if (left[i].num > right[j].num) {
                rightCount++;
                merged.push(right[j++]);
            } else {
                result[left[i].index] += rightCount;
                merged.push(left[i++]);
            }
        }

        while (i < left.length) {
            result[left[i].index] += rightCount;
            merged.push(left[i++]);
        }

        while (j < right.length) {
            merged.push(right[j++]);
        }

        return merged;
    };

    mergeSort(indexedNums);
    return result;
};