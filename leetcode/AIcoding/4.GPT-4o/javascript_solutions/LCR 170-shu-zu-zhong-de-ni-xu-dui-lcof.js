var reversePairs = function(nums) {
    let count = 0;

    function mergeSort(start, end) {
        if (start >= end) return;

        let mid = Math.floor((start + end) / 2);
        mergeSort(start, mid);
        mergeSort(mid + 1, end);

        let j = mid + 1;
        for (let i = start; i <= mid; i++) {
            while (j <= end && nums[i] > 2 * nums[j]) {
                j++;
            }
            count += j - (mid + 1);
        }

        let temp = [];
        let left = start, right = mid + 1;
        while (left <= mid && right <= end) {
            if (nums[left] <= nums[right]) {
                temp.push(nums[left]);
                left++;
            } else {
                temp.push(nums[right]);
                right++;
            }
        }
        while (left <= mid) {
            temp.push(nums[left]);
            left++;
        }
        while (right <= end) {
            temp.push(nums[right]);
            right++;
        }

        for (let i = 0; i < temp.length; i++) {
            nums[start + i] = temp[i];
        }
    }

    mergeSort(0, nums.length - 1);
    return count;
};