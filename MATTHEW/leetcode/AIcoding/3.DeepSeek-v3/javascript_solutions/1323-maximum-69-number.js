var maximum69Number  = function(num) {
    let numStr = num.toString();
    let result = numStr.replace('6', '9');
    return parseInt(result);
};