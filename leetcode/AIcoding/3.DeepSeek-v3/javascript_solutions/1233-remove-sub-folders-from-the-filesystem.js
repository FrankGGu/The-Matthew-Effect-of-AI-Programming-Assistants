var removeSubfolders = function(folder) {
    folder.sort();
    const result = [folder[0]];
    for (let i = 1; i < folder.length; i++) {
        const last = result[result.length - 1];
        if (!folder[i].startsWith(last + '/')) {
            result.push(folder[i]);
        }
    }
    return result;
};