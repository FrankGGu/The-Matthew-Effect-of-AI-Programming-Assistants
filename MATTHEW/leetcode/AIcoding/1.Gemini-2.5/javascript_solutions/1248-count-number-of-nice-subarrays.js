var numberOfSubarrays = function(nums, k) {
    function countAtMostK(arr, maxOdds) {
        let count = 0;
        let left = 0;
        let oddCount = 0;

        for (let right = 0; right < arr.length; right++) {
            if (arr[right] % 2 !== 0) {
                oddCount++;
            }

            while (oddCount > maxOdds) {
                if (arr[left] % 2 !== 0) {
                    oddCount--;
                }
                left++;
            }
            count += (right - left + 1);
        }
        return count;
    }

    return countAtMostK(nums, k) - countAtMostK(nums, k - 1);
};