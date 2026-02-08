var countElements = function(arr) {
    const min = Math.min(...arr);
    const max = Math.max(...arr);
    return arr.filter(num => num > min && num < max).length;
};