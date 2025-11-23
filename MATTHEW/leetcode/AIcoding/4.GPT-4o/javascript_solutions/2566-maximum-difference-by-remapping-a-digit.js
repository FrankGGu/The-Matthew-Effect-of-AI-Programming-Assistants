var minMaxDifference = function(num) {
    const numStr = num.toString();
    const minNumStr = numStr.replace(/(9)/g, '0').replace(/(0)/g, '1');
    const maxNumStr = numStr.replace(/(0)/g, '9');

    const minNum = parseInt(minNumStr);
    const maxNum = parseInt(maxNumStr);

    return maxNum - minNum;
};