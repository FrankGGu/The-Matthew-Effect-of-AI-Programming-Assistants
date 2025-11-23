var findDuplicate = function(paths) {
    const contentMap = new Map();
    for (const path of paths) {
        const parts = path.split(' ');
        const directory = parts[0];
        for (let i = 1; i < parts.length; i++) {
            const fileInfo = parts[i];
            const leftParenIndex = fileInfo.indexOf('(');
            const fileName = fileInfo.substring(0, leftParenIndex);
            const content = fileInfo.substring(leftParenIndex + 1, fileInfo.length - 1);
            const fullPath = directory + '/' + fileName;
            if (!contentMap.has(content)) {
                contentMap.set(content, []);
            }
            contentMap.get(content).push(fullPath);
        }
    }

    const result = [];
    for (const files of contentMap.values()) {
        if (files.length > 1) {
            result.push(files);
        }
    }
    return result;
};