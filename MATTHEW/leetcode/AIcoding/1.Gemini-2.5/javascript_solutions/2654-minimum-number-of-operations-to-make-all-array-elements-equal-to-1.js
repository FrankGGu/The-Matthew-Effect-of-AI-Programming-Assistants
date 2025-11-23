function gcd(a, b) {
    while (b) {
        [a, b] = [b, a % b];
    }
    return a;
}

var minOperations = function(nums) {
    const n = nums.length;

    // Step 1: Count existing 1s in the array.
    let countOnes = 0;
    for (let i = 0; i < n; i++) {
        if (nums[i] === 1) {
            countOnes++;
        }
    }

    // If there are already 1s, we just need to spread them.
    // Each spread operation (e.g., replacing a neighbor with gcd(neighbor, 1))
    // converts one non-1 element to 1.
    // So, we need (n - countOnes) operations.
    if (countOnes > 0) {
        return n - countOnes;
    }

    // Step 2: No existing 1s. We need to create at least one '1'.
    // The number of operations to make one element '1' from a subarray of length L
    // is L - 1. We want to find the minimum such L.
    let minOpsToCreateOne = Infinity; // This will store (min_len - 1)

    // Iterate through all possible subarrays to find the shortest one whose GCD is 1.
    for (let i = 0; i < n; i++) {
        let currentGcd = nums[i];
        for (let j = i + 1; j < n; j++) {
            currentGcd = gcd(currentGcd, nums[j]);
            if (currentGcd === 1) {
                // Found a subarray nums[i...j] whose GCD is 1.
                // The length of this subarray is (j - i + 1).
                // The operations required to make one element within this subarray equal to 1 is (length - 1).
                // So, operations = (j - i + 1) - 1 = j - i.
                minOpsToCreateOne = Math.min(minOpsToCreateOne, j - i);
                // Once we find a GCD of 1 for a given 'i', we can break
                // the inner loop because we are looking for the shortest subarray
                // starting at 'i', and any longer subarray starting at 'i'
                // would result in more operations.
                break;
            }
        }
    }

    // If minOpsToCreateOne is still Infinity, it means no subarray could be reduced to 1.
    // Thus, it's impossible to make any element 1.
    if (minOpsToCreateOne === Infinity) {
        return -1;
    } else {
        // minOpsToCreateOne now holds the minimum operations required to create the first '1'.
        // After creating one '1', we need 'n - 1' additional operations to spread this '1'
        // to all other 'n - 1' elements in the array.
        return minOpsToCreateOne + (n - 1);
    }
};