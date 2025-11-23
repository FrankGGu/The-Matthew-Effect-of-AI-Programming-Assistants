function removeSubfolders(folder) {
    folder.sort();
    const result = [folder[0]];
    for (let i = 1; i < folder.length; i++) {
        const prev = result[result.length - 1];
        if (!folder[i].startsWith(prev + '/')) {
            result.push(folder[i]);
        }
    }
    return result;
}