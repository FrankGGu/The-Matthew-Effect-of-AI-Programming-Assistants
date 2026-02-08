var countRangeSum = function(nums, lower, upper) {
    let n = nums.length;
    let prefixSums = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSums[i + 1] = prefixSums[i] + nums[i];
    }

    let count = 0;

    function mergeSort(arr, start, end) {
        if (start >= end) {
            return;
        }

        let mid = Math.floor((start + end) / 2);
        mergeSort(arr, start, mid);
        mergeSort(arr, mid + 1, end);

        // Counting step
        // For each element arr[i] in the left half [start, mid],
        // count elements arr[j] in the right half [mid+1, end]
        // such that lower <= arr[j] - arr[i] <= upper.
        // This is equivalent to arr[i] + lower <= arr[j] <= arr[i] + upper.
        let k = mid + 1; // pointer for the lower bound of arr[j]
        let p = mid + 1; // pointer for the upper bound of arr[j]
        for (let i = start; i <= mid; i++) {
            // Find k: first index such that arr[k] >= arr[i] + lower
            while (k <= end && arr[k] < arr[i] + lower) {
                k++;
            }
            // Find p: first index such that arr[p] > arr[i] + upper
            while (p <= end && arr[p] <= arr[i] + upper) {
                p++;
            }
            count += (p - k);
        }

        // Merge step
        let temp = new Array(end - start + 1);
        let ptr1 = start;
        let ptr2 = mid + 1;
        let idx = 0;

        while (ptr1 <= mid && ptr2 <= end) {
            if (arr[ptr1] <= arr[ptr2]) {
                temp[idx++] = arr[ptr1++];
            } else {
                temp[idx++] = arr[ptr2++];
            }
        }

        while (ptr1 <= mid) {
            temp[idx++] = arr[ptr1++];
        }

        while (ptr2 <= end) {
            temp[idx++] = arr[ptr2++];
        }

        for (let i = 0; i < temp.length; i++) {
            arr[start + i] = temp[i];
        }
    }

    mergeSort(prefixSums, 0, n);
    return count;
};