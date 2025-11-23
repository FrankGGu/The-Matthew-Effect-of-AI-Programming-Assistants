var doesValidArrayExist = function(derived) {
    let original = 0;
    for (let i = 0; i < derived.length - 1; i++) {
        original ^= derived[i];
    }
    return original === derived[derived.length - 1];
};