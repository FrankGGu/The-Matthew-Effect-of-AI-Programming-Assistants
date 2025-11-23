var medianSlidingWindow = function(nums, k) {
    const result = [];
    const window = [];

    for (let i = 0; i < nums.length; i++) {
        const num = nums[i];
        const pos = binarySearch(window, num);
        window.splice(pos, 0, num);

        if (window.length > k) {
            const outNum = nums[i - k];
            const outPos = binarySearch(window, outNum);
            window.splice(outPos, 1);
        }

        if (window.length === k) {
            const median = k % 2 === 0 
                ? (window[Math.floor(k / 2) - 1] + window[Math.floor(k / 2)]) / 2
                : window[Math.floor(k / 2)];
            result.push(median);
        }
    }

    return result;
};

function binarySearch(arr, target) {
    let left = 0;
    let right = arr.length;

    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        if (arr[mid] < target) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    return left;
}