var maximumSum = function(arr) {
    let maxWithDeletion = arr[0];
    let maxWithoutDeletion = arr[0];
    let maxSum = arr[0];

    for (let i = 1; i < arr.length; i++) {
        maxWithoutDeletion = Math.max(arr[i], maxWithoutDeletion + arr[i]);
        maxWithDeletion = Math.max(maxWithDeletion, maxWithoutDeletion);
        maxSum = Math.max(maxSum, maxWithDeletion, arr[i]);
    }

    return maxSum;
};