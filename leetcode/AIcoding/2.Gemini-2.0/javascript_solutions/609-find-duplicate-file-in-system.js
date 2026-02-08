var findDuplicate = function(paths) {
    const map = new Map();
    for (const path of paths) {
        const parts = path.split(" ");
        const dir = parts[0];
        for (let i = 1; i < parts.length; i++) {
            const file = parts[i];
            const contentStart = file.indexOf("(");
            const contentEnd = file.indexOf(")");
            const filename = file.substring(0, contentStart);
            const content = file.substring(contentStart + 1, contentEnd);

            if (!map.has(content)) {
                map.set(content, []);
            }
            map.get(content).push(dir + "/" + filename);
        }
    }

    const result = [];
    for (const value of map.values()) {
        if (value.length > 1) {
            result.push(value);
        }
    }

    return result;
};