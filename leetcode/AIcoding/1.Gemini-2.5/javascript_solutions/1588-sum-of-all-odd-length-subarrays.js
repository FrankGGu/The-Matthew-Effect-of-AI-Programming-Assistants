var sumOddLengthSubarrays = function(arr) {
    let totalSum = 0;
    const n = arr.length;

    for (let i = 0; i < n; i++) {
        // For each element arr[i], calculate how many odd-length subarrays it belongs to.
        // An element arr[i] can be the rightmost element of `i + 1` subarrays starting from index 0 to i.
        // An element arr[i] can be the leftmost element of `n - i` subarrays ending from index i to n-1.

        // Number of choices for the left endpoint (0 to i)
        const leftCount = i + 1;
        // Number of choices for the right endpoint (i to n-1)
        const rightCount = n - i;

        // Total number of subarrays that contain arr[i] is the product of left and right choices.
        const totalSubarraysContainingI = leftCount * rightCount;

        // Out of these total subarrays, approximately half will have odd length and half will have even length.
        // Specifically, the number of odd-length subarrays containing arr[i] is Math.ceil(totalSubarraysContainingI / 2).
        const oddLengthSubarraysContainingI = Math.ceil(totalSubarraysContainingI / 2);

        // Add arr[i] multiplied by the count of odd-length subarrays it appears in to the total sum.
        totalSum += arr[i] * oddLengthSubarraysContainingI;
    }

    return totalSum;
};