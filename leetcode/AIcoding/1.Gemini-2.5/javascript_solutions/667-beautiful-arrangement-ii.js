var constructArray = function(n, k) {
    const ans = [];
    let left = 1;
    let right = k + 1;

    // Generate the first k+1 elements with k distinct differences
    // This sequence will be 1, k+1, 2, k, 3, k-1, ...
    // The differences generated are k, k-1, k-2, ..., 1.
    while (left <= right) {
        if (ans.length % 2 === 0) {
            ans.push(left);
            left++;
        } else {
            ans.push(right);
            right--;
        }
    }

    // Append the remaining numbers in increasing order.
    // These numbers are k+2, k+3, ..., n.
    // Appending them sequentially ensures that the new differences are all 1,
    // which is already one of the k distinct differences (from the first part).
    for (let i = k + 2; i <= n; i++) {
        ans.push(i);
    }

    return ans;
};