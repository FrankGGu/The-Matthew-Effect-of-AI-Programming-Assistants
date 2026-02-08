var sortTransformedArray = function(nums, a, b, c) {
    const n = nums.length;
    const result = new Array(n);

    // Helper function to calculate f(x) = ax^2 + bx + c
    const calculate = (x) => a * x * x + b * x + c;

    if (a === 0) {
        // Linear case: f(x) = bx + c
        for (let i = 0; i < n; i++) {
            result[i] = calculate(nums[i]);
        }
        // If b is negative, the function is decreasing, so reverse the array.
        // If b is positive or zero, it's non-decreasing, already sorted.
        if (b < 0) {
            result.reverse();
        }
        return result;
    }

    // Quadratic case: a !== 0
    let left = 0;
    let right = n - 1;
    let idx;

    if (a > 0) {
        // Parabola opens upwards.
        // The values increase as x moves away from the vertex.
        // So, the largest values will be at the ends of the original sorted array (nums[0] and nums[n-1]).
        // We fill the result array from right to left with the larger of the two end values.
        idx = n - 1;
        while (left <= right) {
            const valLeft = calculate(nums[left]);
            const valRight = calculate(nums[right]);
            if (valLeft >= valRight) {
                result[idx--] = valLeft;
                left++;
            } else {
                result[idx--] = valRight;
                right--;
            }
        }
    } else { // a < 0
        // Parabola opens downwards.
        // The values decrease as x moves away from the vertex.
        // So, the smallest values will be at the ends of the original sorted array (nums[0] and nums[n-1]).
        // We fill the result array from left to right with the smaller of the two end values.
        idx = 0;
        while (left <= right) {
            const valLeft = calculate(nums[left]);
            const valRight = calculate(nums[right]);
            if (valLeft <= valRight) {
                result[idx++] = valLeft;
                left++;
            } else {
                result[idx++] = valRight;
                right--;
            }
        }
    }

    return result;
};