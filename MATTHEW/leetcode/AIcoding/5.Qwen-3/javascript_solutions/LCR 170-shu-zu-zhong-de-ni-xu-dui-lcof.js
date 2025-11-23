function reversePairs(nums) {
    function mergeSort(arr, left, right) {
        if (left >= right) return 0;
        let mid = Math.floor((left + right) / 2);
        let count = mergeSort(arr, left, mid) + mergeSort(arr, mid + 1, right);
        let i = left, j = mid + 1, k = 0;
        let temp = new Array(right - left + 1);
        while (i <= mid && j <= right) {
            if (arr[i] <= arr[j]) {
                temp[k++] = arr[i++];
            } else {
                temp[k++] = arr[j++];
                count += mid - i + 1;
            }
        }
        while (i <= mid) temp[k++] = arr[i++];
        while (j <= right) temp[k++] = arr[j++];
        for (let m = 0; m < temp.length; m++) {
            arr[left + m] = temp[m];
        }
        return count;
    }
    return mergeSort(nums, 0, nums.length - 1);
}