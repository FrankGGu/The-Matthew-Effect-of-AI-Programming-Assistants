function findDuplicate(paths) {
    const map = new Map();

    for (const path of paths) {
        const [dir, ...files] = path.split(' ');
        for (let i = 0; i < files.length; i++) {
            const file = files[i];
            const [name, content] = file.split('(');
            const key = content.slice(0, -1);
            if (!map.has(key)) {
                map.set(key, []);
            }
            map.get(key).push(`${dir}/${name}`);
        }
    }

    const result = [];
    for (const list of map.values()) {
        if (list.length > 1) {
            result.push(list);
        }
    }

    return result;
}