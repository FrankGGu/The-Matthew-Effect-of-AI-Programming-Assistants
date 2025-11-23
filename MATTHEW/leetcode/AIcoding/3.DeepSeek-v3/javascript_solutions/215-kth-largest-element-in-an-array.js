var findKthLargest = function(nums, k) {
    const quickSelect = (arr, left, right, k) => {
        const pivotIndex = partition(arr, left, right);
        if (pivotIndex === k - 1) {
            return arr[pivotIndex];
        } else if (pivotIndex < k - 1) {
            return quickSelect(arr, pivotIndex + 1, right, k);
        } else {
            return quickSelect(arr, left, pivotIndex - 1, k);
        }
    };

    const partition = (arr, left, right) => {
        const pivot = arr[right];
        let i = left;
        for (let j = left; j < right; j++) {
            if (arr[j] >= pivot) {
                [arr[i], arr[j]] = [arr[j], arr[i]];
                i++;
            }
        }
        [arr[i], arr[right]] = [arr[right], arr[i]];
        return i;
    };

    return quickSelect(nums, 0, nums.length - 1, k);
};