var maxSubarraySumCircular = function(A) {
    const kadane = (arr) => {
        let maxSoFar = arr[0], maxEndingHere = arr[0];
        for (let i = 1; i < arr.length; i++) {
            maxEndingHere = Math.max(arr[i], maxEndingHere + arr[i]);
            maxSoFar = Math.max(maxSoFar, maxEndingHere);
        }
        return maxSoFar;
    };

    const totalSum = A.reduce((a, b) => a + b, 0);
    const maxKadane = kadane(A);

    const minKadane = kadane(A.map(x => -x));
    const maxWrap = totalSum + minKadane;

    return Math.max(maxKadane, maxWrap);
};