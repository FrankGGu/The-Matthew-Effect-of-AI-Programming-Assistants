var replaceElements = function(arr) {
    let maxFromRight = -1;
    for (let i = arr.length - 1; i >= 0; i--) {
        let currentElement = arr[i];
        arr[i] = maxFromRight;
        maxFromRight = Math.max(maxFromRight, currentElement);
    }
    return arr;
};