var getDescriptiveBeauty = function(nums, k, x) {
    const n = nums.length;
    const result = [];
    // freq array to store counts of numbers from -50 to 50.
    // Index i corresponds to value (i - 50).
    // So, index 0 is -50, index 50 is 0, index 100 is 50.
    const freq = new Array(101).fill(0);

    // Helper function to find the x-th smallest element and its beauty
    const findBeauty = () => {
        let count = 0;
        for (let j = 0; j <= 100; j++) {
            count += freq[j];
            if (count >= x) {
                const value = j - 50;
                return value < 0 ? value : 0;
            }
        }
        return 0; 
    };

    // Initialize the first window
    for (let i = 0; i < k; i++) {
        freq[nums[i] + 50]++;
    }
    result.push(findBeauty());

    // Slide the window
    for (let i = k; i < n; i++) {
        // Remove the element leaving the window
        freq[nums[i - k] + 50]--;
        // Add the new element entering the window
        freq[nums[i] + 50]++;
        result.push(findBeauty());
    }

    return result;
};