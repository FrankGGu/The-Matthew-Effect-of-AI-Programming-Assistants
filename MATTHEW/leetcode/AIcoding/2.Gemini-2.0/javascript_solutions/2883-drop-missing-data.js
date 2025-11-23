var dropMissingData = function(arr) {
    return arr.filter(num => Number.isInteger(num));
};