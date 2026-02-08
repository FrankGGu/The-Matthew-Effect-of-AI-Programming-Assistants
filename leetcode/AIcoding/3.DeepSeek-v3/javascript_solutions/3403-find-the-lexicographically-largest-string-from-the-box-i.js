var maxString = function(box) {
    let maxStr = "";
    for (let i = 0; i < box.length; i++) {
        let currentStr = box[i];
        if (currentStr.length > maxStr.length || 
            (currentStr.length === maxStr.length && currentStr > maxStr)) {
            maxStr = currentStr;
        }
    }
    return maxStr;
};