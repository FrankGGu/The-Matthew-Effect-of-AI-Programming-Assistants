var reversePairs = function(nums) {
    let count = 0;

    function mergeSort(arr, start, end) {
        if (start >= end) {
            return;
        }

        let mid = Math.floor((start + end) / 2);
        mergeSort(arr, start, mid);
        mergeSort(arr, mid + 1, end);
        merge(arr, start, mid, end);
    }

    function merge(arr, start, mid, end) {
        let i = start;
        let j = mid + 1;
        while (i <= mid && j <= end) {
            if (arr[i] > 2 * arr[j]) {
                count += (mid - i + 1);
                j++;
            } else {
                i++;
            }
        }

        i = start;
        j = mid + 1;
        let temp = [];
        let k = 0;

        while (i <= mid && j <= end) {
            if (arr[i] <= arr[j]) {
                temp[k++] = arr[i++];
            } else {
                temp[k++] = arr[j++];
            }
        }

        while (i <= mid) {
            temp[k++] = arr[i++];
        }

        while (j <= end) {
            temp[k++] = arr[j++];
        }

        for (let l = 0; l < temp.length; l++) {
            arr[start + l] = temp[l];
        }
    }

    mergeSort(nums, 0, nums.length - 1);
    return count;
};