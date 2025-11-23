var happyStudents = function(nums) {
    nums.sort((a, b) => a - b);
    const n = nums.length;
    let count = 0;

    // Case 1: Select 0 students
    // All students are unselected. For each student i, they are happy if 0 <= nums[i].
    // Since nums[i] >= 0, this condition is always true.
    count++;

    // Case 2: Select k students, where 0 < k < n
    // We select the k students with the smallest nums[i] values (i.e., nums[0]...nums[k-1]).
    // The remaining n-k students (nums[k]...nums[n-1]) are unselected.
    // For selected students (0 to k-1) to be happy: k > nums[i] for i in [0, k-1].
    // This is equivalent to k > nums[k-1] (since nums is sorted).
    // For unselected students (k to n-1) to be happy: k <= nums[i] for i in [k, n-1].
    // This is equivalent to k <= nums[k] (since nums is sorted).
    for (let k = 1; k < n; k++) {
        if (nums[k - 1] < k && k <= nums[k]) {
            count++;
        }
    }

    // Case 3: Select n students
    // All students are selected. For each student i, they are happy if n > nums[i].
    // This is equivalent to n > nums[n-1] (since nums is sorted).
    if (n > 0 && n > nums[n - 1]) {
        count++;
    }

    return count;
};