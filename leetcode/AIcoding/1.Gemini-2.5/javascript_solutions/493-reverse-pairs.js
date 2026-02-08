var reversePairs = function(nums) {
    function mergeSort(arr, start, end) {
        if (start >= end) {
            return 0;
        }

        let mid = Math.floor((start + end) / 2);
        let count = mergeSort(arr, start, mid) + mergeSort(arr, mid + 1, end);

        // Count reverse pairs
        let j = mid + 1;
        for (let i = start; i <= mid; i++) {
            while (j <= end && arr[i] > 2 * arr[j]) {
                j++;
            }
            count += (j - (mid + 1));
        }

        // Merge the two sorted halves
        let temp = [];
        let p1 = start;
        let p2 = mid + 1;

        while (p1 <= mid && p2 <= end) {
            if (arr[p1] <= arr[p2]) {
                temp.push(arr[p1++]);
            } else {
                temp.push(arr[p2++]);
            }
        }

        while (p1 <= mid) {
            temp.push(arr[p1++]);
        }
        while (p2 <= end) {
            temp.push(arr[p2++]);
        }

        for (let k = 0; k < temp.length; k++) {
            arr[start + k] = temp[k];
        }

        return count;
    }

    return mergeSort(nums, 0, nums.length - 1);
};