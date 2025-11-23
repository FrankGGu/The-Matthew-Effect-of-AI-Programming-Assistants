function maxSum(arr, k) {
    arr.sort((a, b) => b - a);
    return arr.slice(0, k).reduce((sum, num) => sum + num, 0);
}