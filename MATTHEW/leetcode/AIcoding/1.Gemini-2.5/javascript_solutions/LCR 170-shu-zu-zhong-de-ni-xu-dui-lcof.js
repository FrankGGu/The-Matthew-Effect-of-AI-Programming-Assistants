var reversePairs = function(nums) {
    function mergeSort(arr, low, high) {
        if (low >= high) {
            return 0;
        }

        let mid = Math.floor((low + high) / 2);
        let currentCount = 0;

        currentCount += mergeSort(arr, low, mid);
        currentCount += mergeSort(arr, mid + 1, high);
        currentCount += merge(arr, low, mid, high);

        return currentCount;
    }

    function merge(arr, low, mid, high) {
        let pairs = 0;
        let j = mid + 1;

        for (let i = low; i <= mid; i++) {
            while (j <= high && arr[i] > 2 * arr[j]) {
                j++;
            }
            pairs += (j - (mid + 1));
        }

        let temp = [];
        let p1 = low;
        let p2 = mid + 1;

        while (p1 <= mid && p2 <= high) {
            if (arr[p1] <= arr[p2]) {
                temp.push(arr[p1++]);
            } else {
                temp.push(arr[p2++]);
            }
        }

        while (p1 <= mid) {
            temp.push(arr[p1++]);
        }

        while (p2 <= high) {
            temp.push(arr[p2++]);
        }

        for (let k = 0; k < temp.length; k++) {
            arr[low + k] = temp[k];
        }

        return pairs;
    }

    return mergeSort(nums, 0, nums.length - 1);
};