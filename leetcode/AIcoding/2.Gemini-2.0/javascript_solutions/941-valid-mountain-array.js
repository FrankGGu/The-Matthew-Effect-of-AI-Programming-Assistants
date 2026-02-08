var validMountainArray = function(arr) {
    if (arr.length < 3) return false;
    let peak = 0;
    for (let i = 1; i < arr.length; i++) {
        if (arr[i] > arr[peak]) {
            peak = i;
        } else {
            break;
        }
    }
    if (peak === 0 || peak === arr.length - 1) return false;
    for (let i = peak; i < arr.length - 1; i++) {
        if (arr[i] <= arr[i + 1]) return false;
    }
    return true;
};