var numberOfChildren = function(n, k) {
    return (k % n === 0) ? n : k % n;
};