var findDuplicate = function(paths) {
    const contentMap = new Map();

    for (const path of paths) {
        const parts = path.split(' ');
        const directory = parts[0];

        for (let i = 1; i < parts.length; i++) {
            const fileEntry = parts[i];
            const fileNameEndIndex = fileEntry.indexOf('(');
            const fileName = fileEntry.substring(0, fileNameEndIndex);
            const content = fileEntry.substring(fileNameEndIndex + 1, fileEntry.length - 1);

            const fullPath = `${directory}/${fileName}`;

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