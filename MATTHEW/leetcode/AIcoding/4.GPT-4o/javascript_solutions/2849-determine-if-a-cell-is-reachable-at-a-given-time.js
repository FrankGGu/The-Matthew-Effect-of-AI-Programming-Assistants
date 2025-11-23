var isReachable = function(x, y, time) {
    return (Math.abs(x) + Math.abs(y) <= time && (time - Math.abs(x) - Math.abs(y)) % 2 === 0);
};