var deleteDuplicateFolder = function(folders) {
    const seen = new Set();
    const map = new Map();

    folders.sort();

    for (const folder of folders) {
        const parts = folder.split('/');
        let current = '';
        let isDuplicate = false;

        for (const part of parts) {
            current += current ? '/' + part : part;
            if (seen.has(current)) {
                isDuplicate = true;
                break;
            }
        }

        if (!isDuplicate) {
            seen.add(folder);
            let parent = '';
            for (const part of parts) {
                parent += parent ? '/' + part : part;
                if (!map.has(parent)) {
                    map.set(parent, []);
                }
                if (parent === folder) break;
            }
        }
    }

    const result = [];
    for (const folder of seen) {
        const parts = folder.split('/');
        let parent = '';
        let valid = true;

        for (const part of parts) {
            parent += parent ? '/' + part : part;
            if (map.has(parent) && map.get(parent).length === 0) {
                valid = false;
                break;
            }
        }

        if (valid) result.push(folder);
    }

    return result;
};