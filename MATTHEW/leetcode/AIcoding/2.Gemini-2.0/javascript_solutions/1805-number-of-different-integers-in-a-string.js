var numDifferentIntegers = function(word) {
    const nums = new Set();
    let numStr = "";
    for (let i = 0; i < word.length; i++) {
        if (isNaN(parseInt(word[i]))) {
            if (numStr !== "") {
                nums.add(BigInt(numStr).toString());
                numStr = "";
            }
        } else {
            numStr += word[i];
        }
    }
    if (numStr !== "") {
        nums.add(BigInt(numStr).toString());
    }
    return nums.size;
};