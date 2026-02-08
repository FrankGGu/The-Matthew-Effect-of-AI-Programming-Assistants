var removeSubfolders = function(folder) {
    folder.sort();
    const result = [folder[0]];
    for (let i = 1; i < folder.length; i++) {
        const prev = result[result.length - 1];
        const curr = folder[i];
        if (!curr.startsWith(prev + '/')) {
            result.push(curr);
        }
    }
    return result;
};