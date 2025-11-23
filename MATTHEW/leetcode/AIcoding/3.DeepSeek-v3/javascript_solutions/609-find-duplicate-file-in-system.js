var findDuplicate = function(paths) {
    const contentMap = {};

    for (const path of paths) {
        const parts = path.split(' ');
        const dir = parts[0];

        for (let i = 1; i < parts.length; i++) {
            const file = parts[i];
            const openParen = file.indexOf('(');
            const closeParen = file.indexOf(')');
            const fileName = file.substring(0, openParen);
            const content = file.substring(openParen + 1, closeParen);

            const fullPath = dir + '/' + fileName;

            if (!contentMap[content]) {
                contentMap[content] = [];
            }
            contentMap[content].push(fullPath);
        }
    }

    const result = [];
    for (const key in contentMap) {
        if (contentMap[key].length > 1) {
            result.push(contentMap[key]);
        }
    }

    return result;
};