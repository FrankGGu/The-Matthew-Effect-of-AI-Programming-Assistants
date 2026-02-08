var removeSubfolders = function(folder) {
    folder.sort();
    const result = [];
    for (let i = 0; i < folder.length; i++) {
        if (i === 0 || !folder[i].startsWith(folder[i - 1] + '/')) {
            result.push(folder[i]);
        }
    }
    return result;
};