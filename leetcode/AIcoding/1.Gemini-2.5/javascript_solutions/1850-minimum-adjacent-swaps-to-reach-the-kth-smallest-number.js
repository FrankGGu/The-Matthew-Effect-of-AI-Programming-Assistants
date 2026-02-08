var getMinSwaps = function(num, k) {
    const originalDigits = num.split('').map(Number);
    const targetDigits = [...originalDigits];

    function nextPermutation(nums) {
        const n = nums.length;
        let i = n - 2;
        while (i >= 0 && nums[i] >= nums[i + 1]) {
            i--;
        }

        if (i >= 0) {
            let j = n - 1;
            while (j >= 0 && nums[j] <= nums[i]) {
                j--;
            }
            [nums[i], nums[j]] = [nums[j], nums[i]];
        }

        let left = i + 1;
        let right = n - 1;
        while (left < right) {
            [nums[left], nums[right]] = [nums[right], nums[left]];
            left++;
            right--;
        }
    }

    for (let i = 0; i < k; i++) {
        nextPermutation(targetDigits);
    }

    function minSwaps(original, target) {
        let swaps = 0;
        const n = original.length;
        const tempOriginal = [...original];

        for (let i = 0; i < n; i++) {
            if (tempOriginal[i] === target[i]) {
                continue;
            }

            let j = i + 1;
            while (j < n && tempOriginal[j] !== target[i]) {
                j++;
            }

            for (let l = j; l > i; l--) {
                [tempOriginal[l], tempOriginal[l - 1]] = [tempOriginal[l - 1], tempOriginal[l]];
                swaps++;
            }
        }
        return swaps;
    }

    return minSwaps(originalDigits, targetDigits);
};