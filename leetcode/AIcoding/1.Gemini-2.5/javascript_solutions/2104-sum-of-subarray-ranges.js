var sumSubarrayRanges = function(nums) {
    const n = nums.length;

    let totalSumOfRanges = 0;

    // Arrays to store indices of previous/next greater/smaller elements
    const previousGreater = new Array(n).fill(-1);
    const nextGreaterOrEqual = new Array(n).fill(n);
    const previousSmaller = new Array(n).fill(-1);
    const nextSmallerOrEqual = new Array(n).fill(n);

    // Monotonic stacks for calculating boundaries
    const stackGreater = []; // Stores indices for previous/next greater elements
    const stackSmaller = []; // Stores indices for previous/next smaller elements

    // Pass 1: Calculate previousGreater and previousSmaller
    for (let i = 0; i < n; i++) {
        // For previousGreater (PGE): find previous strictly greater element
        // Stack maintains indices of elements in decreasing order of their values
        while (stackGreater.length > 0 && nums[stackGreater[stackGreater.length - 1]] <= nums[i]) {
            stackGreater.pop();
        }
        if (stackGreater.length > 0) {
            previousGreater[i] = stackGreater[stackGreater.length - 1];
        }
        stackGreater.push(i);

        // For previousSmaller (PSE): find previous strictly smaller element
        // Stack maintains indices of elements in increasing order of their values
        while (stackSmaller.length > 0 && nums[stackSmaller[stackSmaller.length - 1]] >= nums[i]) {
            stackSmaller.pop();
        }
        if (stackSmaller.length > 0) {
            previousSmaller[i] = stackSmaller[stackSmaller.length - 1];
        }
        stackSmaller.push(i);
    }

    // Clear stacks for the next pass (next greater/smaller)
    stackGreater.length = 0;
    stackSmaller.length = 0;

    // Pass 2: Calculate nextGreaterOrEqual and nextSmallerOrEqual (iterate backward)
    for (let i = n - 1; i >= 0; i--) {
        // For nextGreaterOrEqual (NGEE): find next greater or equal element
        // Stack maintains indices of elements in decreasing order of their values
        while (stackGreater.length > 0 && nums[stackGreater[stackGreater.length - 1]] < nums[i]) {
            stackGreater.pop();
        }
        if (stackGreater.length > 0) {
            nextGreaterOrEqual[i] = stackGreater[stackGreater.length - 1];
        }
        stackGreater.push(i);

        // For nextSmallerOrEqual (NSEE): find next smaller or equal element
        // Stack maintains indices of elements in increasing order of their values
        while (stackSmaller.length > 0 && nums[stackSmaller[stackSmaller.length - 1]] > nums[i]) {
            stackSmaller.pop();
        }
        if (stackSmaller.length > 0) {
            nextSmallerOrEqual[i] = stackSmaller[stackSmaller.length - 1];
        }
        stackSmaller.push(i);
    }

    // Calculate the sum of (max - min) for all subarrays
    // This is equivalent to (Sum of all maximums) - (Sum of all minimums)
    let sumOfMaximums = 0;
    let sumOfMinimums = 0;

    for (let i = 0; i < n; i++) {
        // For each element nums[i], calculate its contribution as a maximum
        // (i - previousGreater[i]) gives the number of choices for the left boundary
        // (nextGreaterOrEqual[i] - i) gives the number of choices for the right boundary
        // Product is the total number of subarrays where nums[i] is the maximum
        const leftCountMax = i - previousGreater[i];
        const rightCountMax = nextGreaterOrEqual[i] - i;
        sumOfMaximums += nums[i] * leftCountMax * rightCountMax;

        // For each element nums[i], calculate its contribution as a minimum
        // (i - previousSmaller[i]) gives the number of choices for the left boundary
        // (nextSmallerOrEqual[i] - i) gives the number of choices for the right boundary
        // Product is the total number of subarrays where nums[i] is the minimum
        const leftCountMin = i - previousSmaller[i];
        const rightCountMin = nextSmallerOrEqual[i] - i;
        sumOfMinimums += nums[i] * leftCountMin * rightCountMin;
    }

    totalSumOfRanges = sumOfMaximums - sumOfMinimums;

    return totalSumOfRanges;
};