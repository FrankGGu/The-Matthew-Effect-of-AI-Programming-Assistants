var maximumValue = function(A, newInteger) {
    A.push(newInteger);
    return Math.max(...A);
};