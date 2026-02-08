var findDuplicate = function(paths) {
    const map = new Map();
    for (const path of paths) {
        const parts = path.split(' ');
        const directory = parts[0];
        for (let i = 1; i < parts.length; i++) {
            const fileInfo = parts[i];
            const idx = fileInfo.indexOf('(');
            const fileName = fileInfo.substring(0, idx);
            const content = fileInfo.substring(idx);
            const fullPath = directory + '/' + fileName;
            if (!map.has(content)) {
                map.set(content, []);
            }
            map.get(content).push(fullPath);
        }
    }
    return [...map.values()].filter(files => files.length > 1);
};