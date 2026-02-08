var removeSubfolders = function(folder) {
    folder.sort();

    const result = [];
    let lastRoot = "";

    for (let i = 0; i < folder.length; i++) {
        const currentFolder = folder[i];

        if (result.length === 0 || 
            !(currentFolder.startsWith(lastRoot) && 
              currentFolder.length > lastRoot.length && 
              currentFolder[lastRoot.length] === '/')
           ) {
            result.push(currentFolder);
            lastRoot = currentFolder;
        }
    }

    return result;
};