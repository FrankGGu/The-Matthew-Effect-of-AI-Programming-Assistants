var findDuplicate = function(files) {
    const map = new Map();
    const result = [];

    for (const file of files) {
        const parts = file.split(' ');
        const dir = parts[0];

        for (let i = 1; i < parts.length; i++) {
            const filename = parts[i].substring(0, parts[i].indexOf('('));
            const content = parts[i].substring(parts[i].indexOf('(') + 1, parts[i].indexOf(')'));

            if (!map.has(content)) {
                map.set(content, []);
            }

            map.get(content).push(dir + '/' + filename);
        }
    }

    for (const paths of map.values()) {
        if (paths.length > 1) {
            result.push(paths);
        }
    }

    return result;
};