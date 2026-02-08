var countInversions = function(nums) {

    function mergeSortAndCount(arr, low, high) {
        if (low >= high) {
            return 0;
        }

        const mid = Math.floor((low + high) / 2);
        let inversions = 0;
        inversions += mergeSortAndCount(arr, low, mid);
        inversions += mergeSortAndCount(arr, mid + 1, high);
        inversions += mergeAndCountSplitInversions(arr, low, mid, high);
        return inversions;
    }

    function mergeAndCountSplitInversions(arr, low, mid, high) {
        const temp = new Array(high - low + 1);
        let i = low;
        let j = mid + 1;
        let k = 0;
        let inversions = 0;

        while (i <= mid && j <= high) {
            if (arr[i] <= arr[j]) {
                temp[k++] = arr[i++];
            } else {
                temp[k++] = arr[j++];
                inversions += (mid - i + 1);
            }
        }

        while (i <= mid) {
            temp[k++] = arr[i++];
        }

        while (j <= high) {
            temp[k++] = arr[j++];
        }

        for (let idx = 0; idx < temp.length; idx++) {
            arr[low + idx] = temp[idx];
        }

        return inversions;
    }

    return mergeSortAndCount(nums, 0, nums.length - 1);
};