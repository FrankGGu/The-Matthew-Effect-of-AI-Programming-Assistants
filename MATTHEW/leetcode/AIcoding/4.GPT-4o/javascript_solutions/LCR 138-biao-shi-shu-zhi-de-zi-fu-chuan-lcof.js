var isNumber = function(s) {
    const regex = /^[+-]?(\d+(\.\d*)?|\.\d+)([eE][+-]?\d+)?$/;
    return regex.test(s.trim());
};