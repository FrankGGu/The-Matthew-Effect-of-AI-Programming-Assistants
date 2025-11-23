var maxTurbulenceSize = function(arr) {
    if (arr.length < 2) return arr.length;
    let maxLength = 1, currentLength = 1;

    for (let i = 1; i < arr.length; i++) {
        if ((arr[i] > arr[i - 1] && (i === 1 || arr[i - 1] <= arr[i - 2])) || 
            (arr[i] < arr[i - 1] && (i === 1 || arr[i - 1] >= arr[i - 2]))) {
            currentLength++;
        } else if (arr[i] !== arr[i - 1]) {
            currentLength = 2;
        } else {
            currentLength = 1;
        }
        maxLength = Math.max(maxLength, currentLength);
    }

    return maxLength;
};