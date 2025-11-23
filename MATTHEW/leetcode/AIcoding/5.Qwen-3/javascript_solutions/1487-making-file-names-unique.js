function getFolderNames(paths) {
    const nameMap = {};
    const result = [];

    for (const path of paths) {
        let [dir, name] = path.split('/');
        if (!nameMap[name]) {
            nameMap[name] = 1;
            result.push(path);
        } else {
            let count = nameMap[name];
            let newName = `${name}.${count}`;
            while (nameMap[newName]) {
                count++;
                newName = `${name}.${count}`;
            }
            nameMap[name] = count + 1;
            nameMap[newName] = 1;
            result.push(`${dir}/${newName}`);
        }
    }

    return result;
}