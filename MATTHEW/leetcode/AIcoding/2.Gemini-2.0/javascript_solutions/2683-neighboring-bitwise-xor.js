var doesValidArrayExist = function(derived) {
    let xorSum = 0;
    for (let num of derived) {
        xorSum ^= num;
    }
    return xorSum === 0;
};