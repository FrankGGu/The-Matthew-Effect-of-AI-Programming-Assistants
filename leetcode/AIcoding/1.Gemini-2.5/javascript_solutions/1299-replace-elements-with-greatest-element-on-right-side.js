var replaceElements = function(arr) {
    let maxRight = -1;

    for (let i = arr.length - 1; i >= 0; i--) {
        let currentElement = arr[i];
        arr[i] = maxRight;
        maxRight = Math.max(maxRight, currentElement);
    }

    return arr;
};