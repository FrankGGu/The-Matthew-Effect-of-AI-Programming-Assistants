var findLengthOfShortestSubarray = function(arr) {
    const n = arr.length;

    // Step 1: Find the longest non-decreasing prefix
    // 'i' will be the last index of this prefix.
    let i = 0;
    while (i < n - 1 && arr[i] <= arr[i + 1]) {
        i++;
    }

    // If the entire array is already sorted, no removal is needed.
    if (i === n - 1) {
        return 0;
    }

    // Step 2: Find the longest non-decreasing suffix
    // 'j' will be the first index of this suffix.
    let j = n - 1;
    while (j > 0 && arr[j - 1] <= arr[j]) {
        j--;
    }

    // Step 3: Initialize the minimum length of the subarray to remove.
    // This covers two basic scenarios:
    // 1. Remove arr[i+1 ... n-1] (remaining is arr[0 ... i]). Length to remove is n - (i + 1).
    // 2. Remove arr[0 ... j-1] (remaining is arr[j ... n-1]). Length to remove is j.
    let ans = Math.min(n - (i + 1), j);

    // Step 4: Iterate through the prefix (arr[0 ... i]) and suffix (arr[j ... n-1])
    // to find a combined sorted array by removing a middle part.
    // 'p' iterates through the elements of the valid prefix.
    // 's_ptr' iterates through the elements of the valid suffix.
    let s_ptr = j; // Start s_ptr from the beginning of the valid suffix.
    for (let p = 0; p <= i; p++) {
        // For the current prefix element arr[p], we need to find the smallest
        // element arr[s_ptr] in the suffix such that arr[p] <= arr[s_ptr].
        // We advance s_ptr as long as arr[p] is greater than arr[s_ptr]
        // and s_ptr is within bounds.
        while (s_ptr < n && arr[p] > arr[s_ptr]) {
            s_ptr++;
        }

        // If s_ptr is still within bounds (meaning we found a valid suffix element)
        // then arr[p] <= arr[s_ptr].
        // This forms a potentially sorted combined array: arr[0...p] followed by arr[s_ptr...n-1].
        // The subarray removed is arr[p+1 ... s_ptr-1].
        // Its length is (s_ptr - 1) - (p + 1) + 1 = s_ptr - p - 1.
        if (s_ptr < n) {
            ans = Math.min(ans, s_ptr - p - 1);
        }
    }

    return ans;
};