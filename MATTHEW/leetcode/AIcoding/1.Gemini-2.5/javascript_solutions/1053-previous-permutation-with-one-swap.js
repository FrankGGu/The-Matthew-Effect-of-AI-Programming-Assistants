var prevPermOpt1 = function(arr) {
    const n = arr.length;

    // Step 1: Find the largest index i such that arr[i] > arr[i+1]
    // This 'i' is the pivot element. We iterate from right to left.
    let i = n - 2;
    while (i >= 0 && arr[i] <= arr[i+1]) {
        i--;
    }

    // If no such index exists, the array is already sorted in non-decreasing order.
    // In this case, no smaller permutation can be formed by one swap.
    // Return the original array as per problem statement.
    if (i === -1) {
        return arr;
    }

    // Step 2: Find the largest index j such that arr[j] < arr[i].
    // Among all such elements, we want the one with the largest value.
    // If there are multiple elements with the same largest value that are smaller than arr[i],
    // we pick the rightmost one (largest index j).
    let swapJ = -1;
    let maxValSmallerThan_arr_i = -1; // Constraints: arr[k] are positive integers, so -1 is a safe initial value

    // Iterate from right to left in the suffix arr[i+1...n-1]
    for (let k = n - 1; k > i; k--) {
        if (arr[k] < arr[i]) {
            if (arr[k] > maxValSmallerThan_arr_i) {
                maxValSmallerThan_arr_i = arr[k];
                swapJ = k;
            }
            // If arr[k] == maxValSmallerThan_arr_i, we do nothing.
            // This is because we are iterating from right to left.
            // If `swapJ` was already set to an index `k'` where `arr[k'] == maxValSmallerThan_arr_i`,
            // and we find another `k < k'` with `arr[k] == maxValSmallerThan_arr_i`,
            // we want to keep the rightmost `k'`, so we don't update `swapJ`.
        }
    }

    // Step 3: Swap arr[i] and arr[swapJ]
    // Using array destructuring for a concise swap operation.
    [arr[i], arr[swapJ]] = [arr[swapJ], arr[i]];

    return arr;
};