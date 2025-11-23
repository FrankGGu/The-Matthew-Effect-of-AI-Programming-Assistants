var maximumSum = function(arr) {
    const n = arr.length;
    if (n === 1) return arr[0];

    let noDelete = new Array(n).fill(0);
    let oneDelete = new Array(n).fill(0);

    noDelete[0] = arr[0];
    oneDelete[0] = 0;
    let max = Math.max(noDelete[0], oneDelete[0]);

    for (let i = 1; i < n; i++) {
        noDelete[i] = Math.max(arr[i], noDelete[i - 1] + arr[i]);
        oneDelete[i] = Math.max(noDelete[i - 1], oneDelete[i - 1] + arr[i]);
        max = Math.max(max, noDelete[i], oneDelete[i]);
    }

    return max;
};