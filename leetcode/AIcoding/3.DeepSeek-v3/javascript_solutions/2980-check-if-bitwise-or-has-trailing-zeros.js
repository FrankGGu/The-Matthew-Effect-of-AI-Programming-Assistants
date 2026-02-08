var doesValidArrayExist = function(derived) {
    let xor = 0;
    for (let num of derived) {
        xor ^= num;
    }
    return xor === 0;
};